class User
  module Favorite
    extend ActiveSupport::Concern

    included do
      action_store :favorite, :info,  counter_cache: true
      action_store :favorite, :main_event, counter_cache: true
    end

    # 收藏
    def favorite(target)
      return false if target.blank?
      create_action(:favorite, target: target)
    end

    # 取消收藏
    def unfavorite(target)
      return false if target.blank?
      destroy_action(:favorite, target: target)
    end

    # 是否收藏过
    def favorite?(target)
      find_action(:favorite, target: target).present?
    end
  end
end