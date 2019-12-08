class AdminUserRole < ApplicationRecord
  belongs_to :admin_role
  belongs_to :admin_user
  has_paper_trail
end
