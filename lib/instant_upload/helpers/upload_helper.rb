module InstantUpload
  module Helpers

    module UploadHelper

      def instant_upload_for(record, field, options = {})
        partial ||= options[:multi].present? ? 'instant_upload/multi' : 'instant_upload/single'
        render partial: partial, locals: { record: record, field: field, options: { field: field, persisted: record.persisted?.to_s }.merge(options) }
      end

    end

  end
end
