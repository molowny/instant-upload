class CreateInstantUploadUploads < ActiveRecord::Migration
  def change
    create_table :instant_upload_uploads do |t|
      t.string :file, null: false

      t.timestamps
    end
  end
end
