class CashGame < ApplicationRecord
  mount_uploader :image, ImageUploader
  mount_uploader :image_en, ImageUploader
  mount_uploader :image_complex, ImageUploader
  has_many :cash_queues, dependent: :destroy
  scope :position_desc, -> { order(position: :desc).order(created_at: :desc) }

  before_create do
    self.position = CashGame.position_desc.first&.position.to_f + 100000
  end

  def amap_navigation_url
    "https://uri.amap.com/navigation?to=#{amap_location},#{name}&src=kkapi&callnative=1"
  end
end
