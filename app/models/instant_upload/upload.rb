module InstantUpload
  class Upload < ActiveRecord::Base
    mount_uploader :file, FileUploader
  end
end
