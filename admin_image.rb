class AdminImage < ApplicationRecord
  mount_uploader :image, ImageUploader
  belongs_to :imageable, polymorphic: true, optional: true
end
