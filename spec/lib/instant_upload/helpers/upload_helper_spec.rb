require 'spec_helper'

module InstantUpload
  describe Helpers::UploadHelper, type: :helper do

    context 'single upload' do
      it 'create' do
        helper.instant_upload_for(User.new, :avatar).should have_tag('p')
      end
    end

  end
end