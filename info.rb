class Info < ApplicationRecord
  include Publishable

  mount_uploader :image, ImageUploader

  after_initialize do
    self.created_at ||= Time.current
  end

  scope :position_desc, -> { order(position: :desc) }
  before_create do
    self.position = Info.position_desc.first&.position.to_f + 100000
  end

  def hot!
    update(hot: true)
  end

  def unhot!
    update(hot: false)
  end
end
