class AdminUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  if ENV['CURRENT_PROJECT'] == 'cms'
    devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable
  end

  has_many :admin_user_roles
  has_many :admin_roles, through: :admin_user_roles
  has_paper_trail on: [:destroy]

  def permissions
    @permissions ||= admin_roles.map(&:permissions).flatten.uniq
  end

  def has_super_permission?
    admin_roles.pluck(:name).include?('Super Admin')
  end
end
