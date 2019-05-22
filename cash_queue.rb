class CashQueue < ApplicationRecord
  belongs_to :cash_game
  has_many :cash_queue_members, dependent: :destroy

  def table_nums
    table_no.split(',').count
  end
end
