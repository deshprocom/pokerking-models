class User < ApplicationRecord
  mount_uploader :avatar, ImageUploader
  include UserFinders
  include UserUniqueValidator
  include UserNameGenerator
  include UserCreator
  include User::Favorite
  has_many :actions, dependent: :destroy
  has_many :notifications
  has_many :cash_queue_members, dependent: :destroy
  # 新增用户和实名为 多对1 的关系
  has_many :user_extras

  def touch_visit!
    self.last_visit = Time.zone.now
    save
  end
  
  def increase_login_count
    # 登录次数+1
    increment!(:login_count)
    # 登录天数+1
    interval_day = (Time.zone.today - last_visit.to_date).to_i
    increment!(:login_days) if interval_day >= 1
  end

  def action_favorites
    actions.where(action_type: 'favorite')
  end

  def notifies type
    case type
    when 'event'
      Notification.where(notify_type: 'event')
    when 'apply'
      notifications.where('notify_type = ? or notify_type = ?', 'scan_apply', 'cancel_apply')
    else
      notifications
    end.order(id: :desc)
  end

  def self.event_notify_users
    User.find(User.where(event_notify: true).pluck(:id))
  end

  def notify_apply_unread_new
    notify_apply_unread < 0 ? 0 : notify_apply_unread
  end

  def notify_event_unread_new
    notify_event_unread < 0 ? 0 : notify_event_unread
  end
end
