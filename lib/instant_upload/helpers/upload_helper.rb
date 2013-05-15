module InstantUpload
  module Helpers

    module UploadHelper

      def instant_upload_for(record, resource, options = {})
        if record.persisted? || session[:user_avatar].blank?
          preview = record.send(resource).send(options[:version]).url
        else
          tmp_file = InstantUpload::Upload.find(session[:user_avatar])
          preview = tmp_file.file.url
        end

        render partial: 'instant_upload/single', locals: { record: record, resource: resource, preview: preview, options: options }
      end

      def multi_instant_upload_for(record, resource, options = {})
        # if record.persisted? || session[:user_avatar].blank?
        #   preview = record.send(resource).send(options[:version]).url
        # else
        #   tmp_file = InstantUpload::Upload.find(session[:user_avatar])
        #   preview = tmp_file.file.url
        # end

        render partial: 'instant_upload/multi', locals: { record: record, resource: resource, options: options }
      end

    end

  end
end
