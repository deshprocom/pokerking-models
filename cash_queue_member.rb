class CashQueueMember < ApplicationRecord
  belongs_to :cash_queue, counter_cache: true
  include Cancelable
  validates :nickname, presence: true, uniqueness:true
end
