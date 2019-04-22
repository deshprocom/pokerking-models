class AdminRole < ApplicationRecord
  has_many :admin_user_roles, dependent: :destroy
  has_many :admin_users, through: :admin_user_roles
  serialize :permissions, JSON

  def permissions_text
    @permissions_text ||= permissions.inject('') do |text, item|
      "#{text} #{I18n.t("activerecord.models.#{item}")}"
    end
  end
end
