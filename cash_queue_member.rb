class CashQueueMember < ApplicationRecord
  belongs_to :cash_queue, counter_cache: true
  include Cancelable
  # validates :nickname, presence: true, uniqueness:true
  scope :position_desc, -> { order(position: :desc).current_day }
  scope :position_asc, -> { order(position: :asc).current_day }
  scope :current_day, -> {where('created_at >= ? and created_at <= ?', Date.current.beginning_of_day, Date.current.end_of_day)}

  before_create do
    self.position = CashQueueMember.position_desc.first&.position.to_f + 100000
  end
end
