class CashGameFeedback < ApplicationRecord
  has_many :cash_game_feedback_images, dependent: :destroy
end
