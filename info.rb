class Info < ApplicationRecord
  include Publishable

  mount_uploader :image, ImageUploader

  after_initialize do
    self.created_at ||= Time.current
  end
end
