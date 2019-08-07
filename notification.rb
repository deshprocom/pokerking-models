class Notification < ApplicationRecord
  belongs_to :source, polymorphic: true
  belongs_to :user
  serialize :extra_data

  after_create do
    DpPush::NotifyUser.call(user, content)
  end

  def self.create_queue_notify(user, cash_queue)
    cash_game_name = cash_queue.cash_game.name # 扑克房名字
    apply_index = cash_queue.current_user_index(user) # 报名后的序号
    content = "您所参加的：#{cash_game_name}盲注#{cash_queue.blind_info}前面还有#{apply_index}位在排队等候！请及时赶往现场办理入场手续！"
    create(user: user,
           notify_type: 'scan_apply',
           title: '排队进程通知',
           content: content,
           source: cash_queue)
  end
end
