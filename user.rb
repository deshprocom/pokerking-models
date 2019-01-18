class User < ApplicationRecord
  include UserFinders
  include UserUniqueValidator
  include UserNameGenerator
  include UserCreator

  def touch_visit!
    self.last_visit = Time.zone.now
    save
  end
end
