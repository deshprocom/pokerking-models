class CashQueue < ApplicationRecord
  belongs_to :cash_game
  has_many :cash_queue_members, dependent: :destroy
end
