class CashGame < ApplicationRecord
  mount_uploader :image, ImageUploader
  has_many :cash_queues, dependent: :destroy
end
