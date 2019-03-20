class Feedback < ApplicationRecord
  has_many :feedback_images, dependent: :destroy
end
