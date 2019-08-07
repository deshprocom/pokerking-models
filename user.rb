class User < ApplicationRecord
  mount_uploader :avatar, ImageUploader
  include UserFinders
  include UserUniqueValidator
  include UserNameGenerator
  include UserCreator
  include User::Favorite
  has_many :actions, dependent: :destroy
  has_many :notifications

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
end
