class Feedback < ApplicationRecord
  mount_uploader :image, ImageUploader
end
