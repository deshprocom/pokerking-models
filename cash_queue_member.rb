class CashQueueMember < ApplicationRecord
  belongs_to :cash_queue, counter_cache: true
  include Cancelable
  validates :nickname, presence: true, uniqueness:true
  scope :position_desc, -> { order(position: :desc) }

  before_create do
    self.position = CashQueueMember.position_desc.first&.position.to_f + 100000
  end
end
