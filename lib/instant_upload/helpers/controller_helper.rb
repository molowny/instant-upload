module InstantUpload
  module Helpers

    module ControllerHelper
      extend ActiveSupport::Concern

      included do
        helper_method :handle_upload, :load_uploaded_files, :clear_uploaded_files, :remove_uploaded_file
      end

      def handle_upload(record, field, options ={})
        sesssion_key = "#{record.class.name.downcase}_#{field}"

        if request.env['HTTP_X_INSTANT_UPLOAD']
          if options[:multi].present? # multiple
            files = []

            record.send(field).each do |img|
              file = InstantUpload::Upload.new
              file.file = img.path
              file.save
              files << file
            end

            session[sesssion_key] = [] if session[sesssion_key].blank?
            session[sesssion_key] = files.map { |f| f.id }

            render json: record.send(field)
          else
            file = InstantUpload::Upload.new
            file.file = record.send(field)
            file.save

            session[sesssion_key] = file.id

            render json: record
          end

          return true
        else
           if remove_uploaded_file(record, field)
            render json: true
            return true
          end
          load_uploaded_files(record, field, options)
        end

        false
      end

      def load_uploaded_files(record, field, options ={})
        sesssion_key = "#{record.class.name.downcase}_#{field}"

        if session[sesssion_key].present?
          if options[:multi].present? # multiple
            files = InstantUpload::Upload.find(session[sesssion_key])
            record.send(field).clear

            files.each do |f|
              record.send(field).build(options[:multi] => f.file)
            end
          else # single
            file = InstantUpload::Upload.find(session[sesssion_key])
            record.send("#{field}=", file.file)
          end
        end
      end

      def clear_uploaded_files(record, field)
        session.delete("#{record.class.name.downcase}_#{field}")
      end

      def remove_uploaded_file(record, field)
        sesssion_key = "#{record.class.name.downcase}_#{field}"

        if params[:iu_remove].present?
          logger.info 'remove media'
          logger.info session[sesssion_key].inspect
          session[sesssion_key].delete_at params[:index].to_i
          return true
        end

        false
      end

    end

  end
end
