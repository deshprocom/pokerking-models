class CashQueue < ApplicationRecord
  belongs_to :cash_game
  has_many :cash_queue_members, dependent: :destroy

  # 当天排队的人数
  def current_day_members
    cash_queue_members.count
  end
end
