class CashQueue < ApplicationRecord
  mount_uploader :navigation, ImageUploader
  belongs_to :cash_game
  has_many :cash_queue_members, dependent: :destroy
  scope :position_desc, -> { order(position: :desc) }
  scope :position_asc, -> { order(position: :asc) }

  before_create do
    self.position = CashQueue.position_desc.first&.position.to_f + 100000
  end

  def table_nums
    table_no.split(',').count
  end

  def blind_info
    straddle.to_i.zero? ? "#{small_blind}/#{big_blind}" : "#{small_blind}/#{big_blind}/#{straddle}"
  end

  def queue_type_tmp
    if !high_limit && !transfer
      'basic'
    elsif high_limit
      'high limit'
    else
      'transfer request'
    end
  end
end
