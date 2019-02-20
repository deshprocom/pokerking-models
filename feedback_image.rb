class FeedbackImage < ApplicationRecord
  mount_uploader :image, ImageUploader
  belongs_to :feedback
end
