class Product < ActiveRecord::Base
  has_many :images, dependent: :destroy
  accepts_nested_attributes_for :images
  validates :name, presence: true
end
