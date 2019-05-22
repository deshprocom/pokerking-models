class CashGame < ApplicationRecord
  mount_uploader :image, ImageUploader
  mount_uploader :image_en, ImageUploader
  mount_uploader :image_complex, ImageUploade
  has_many :cash_queues, dependent: :destroy
  scope :position_desc, -> { order(position: :desc).order(created_at: :desc) }

  before_create do
    self.position = CashGame.position_desc.first&.position.to_f + 100000
  end
end
