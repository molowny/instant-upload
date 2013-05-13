# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :instant_upload_upload, :class => 'Upload' do
    file "MyString"
  end
end
