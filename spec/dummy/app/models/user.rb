class User < ActiveRecord::Base
  mount_uploader :avatar, AvatarUploader

  validates :name, presence: true
end
