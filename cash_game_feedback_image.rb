class CashGameFeedbackImage < ApplicationRecord
  mount_uploader :image, ImageUploader
  belongs_to :cash_game_feedback
end
