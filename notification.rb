class Notification < ApplicationRecord
  belongs_to :source, polymorphic: true
  belongs_to :user, optional: true
  serialize :extra_data

  after_create do
    flag = check_notify(user, self)
    DpPush::NotifyUser.call(user, content) if flag # 打开了消息通知才推送
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
  end

  def self.cancel_queue_notify(user, cash_queue)
    cash_game_name = cash_queue.cash_game.name # 扑克房名字
    content = "您所参加的#{cash_game_name}盲注#{cash_queue.blind_info}NLH已取消排队等候！"
    create(user: user,
           notify_type: 'cancel_apply',
           title: '取消排队通知',
           content: content,
           source: cash_queue)
  end

  def self.create_info_notify(info)
    info_name = info.title # 资讯的名称
    content = info_name
    create(user: nil,
           notify_type: 'info',
           title: info_name,
           content: content,
           source: info)
  end

  def check_notify(user, resource)
    # 判断是否下发消息
    case resource.notify_type
    when 'scan_apply'
      user.apply_notify
    when 'cancel_apply'
      user.apply_notify
    when 'event'
      user.event_notify
    else
      false
    end
  end
end
