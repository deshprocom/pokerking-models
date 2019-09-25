class Feedback < ApplicationRecord
  has_many :feedback_images, dependent: :destroy
  belongs_to :user, optional: true
end
