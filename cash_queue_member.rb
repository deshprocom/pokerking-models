class CashQueueMember < ApplicationRecord
  belongs_to :cash_queue, counter_cache: true
  include Cancelable
  # validates :nickname, presence: true, uniqueness:true
  scope :current_day, -> { where('created_at >= ? and created_at <= ?', Date.current.beginning_of_day, Date.current.end_of_day) }
  scope :position_desc, -> { order(position: :desc) }
  scope :position_asc, -> { order(position: :asc) }
  scope :confirmed_numbers, -> { where(confirmed: true) }
  scope :unconfirmed_numbers, -> { where(confirmed: false) }
  belongs_to :user, optional: true
  if ENV['CURRENT_PROJECT'] == 'cms'
    has_paper_trail
  end

  before_create do
    self.position = CashQueueMember.position_desc.first&.position.to_f + 100000
  end

  def get_index
    queue_members = cash_queue.cash_queue_members.position_asc
    index = 0
    queue_members.each_with_index do |v, k|
      break index = k if v.eql?(self)
    end
    index + 1
  end
end
