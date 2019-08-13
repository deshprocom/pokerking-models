class Notification < ApplicationRecord
  belongs_to :source, polymorphic: true
  belongs_to :user, optional: true
  serialize :extra_data

  after_create do
    send_notify(user, self)
  end

  def self.create_queue_notify(user, cash_queue)
    cash_game_name = cash_queue.cash_game.name # 扑克房名字
    apply_index = cash_queue.current_user_index(user) # 报名后的序号
    content = "您所参加的：#{cash_game_name}盲注#{cash_queue.blind_info}NLH前面还有#{apply_index}位在排队等候！请及时赶往现场办理入场手续！"
    create(user: user,
           notify_type: 'scan_apply',
           title: '排队进程通知',
           content: content,
           source: cash_queue)
    user.increment!(:notify_apply_unread)
  end

  def self.cancel_queue_notify(user, cash_queue)
    cash_game_name = cash_queue.cash_game.name # 扑克房名字
    content = "您所参加的#{cash_game_name}盲注#{cash_queue.blind_info}NLH已取消排队等候！"
    create(user: user,
           notify_type: 'cancel_apply',
           title: '取消排队通知',
           content: content,
           source: cash_queue)
    user.decrement!(:notify_apply_unread)
  end

  def self.create_info_notify(info)
    info_name = info.title # 资讯的名称
    content = info_name
    create(user: nil,
           notify_type: 'event',
           title: info_name,
           content: content,
           source: info)
    User.all.each do |user|
      # 给每一个用户记录有新闻未读
      unread = user.notify_event_unread
      unread_new = unread + 1
      user.update(notify_event_unread: unread_new)
    end
  end

  def send_notify(user, resource)
    # 判断是否下发消息
    case resource.notify_type
    when 'scan_apply'
      DpPush::NotifyUser.call(user, resource.content) if user.apply_notify
    when 'cancel_apply'
      DpPush::NotifyUser.call(user, resource.content) if user.apply_notify
    when 'event'
      # 这里是给所有开启通知项的用户下发消息
      event_notify_users.each do |u|
        DpPush::NotifyUser.call(u, resource.content)
      end
    else
      false
    end
  end
end
