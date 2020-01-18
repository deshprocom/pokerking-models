class CashQueue < ApplicationRecord
  mount_uploader :navigation, ImageUploader
  belongs_to :cash_game
  has_many :cash_queue_members, dependent: :destroy
  scope :position_desc, -> { order(position: :desc) }
  scope :position_asc, -> { order(position: :asc) }
  has_many :notifications, as: :source, dependent: :destroy
  has_paper_trail

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

  def current_user_index(current_user)
    return '' if current_user.blank?
    # 查看当前用户 该queue下面是否有报名 如果有 取出其在该盲注下的报名序号
    member = cash_queue_members.where(user_id: current_user.id)&.first
    return '' if member.blank?
    member.get_index
  end

  def current_user_apply_status(current_user)
    return 'none' if current_user.blank?
    # 查看当前用户 该queue下面是否有报名 如果有 取出其在该盲注下的报名序号
    member = cash_queue_members.where(user_id: current_user.id)&.first
    return 'none' if member.blank?
    member.confirmed ? 'success' : 'pending'
  end
end
