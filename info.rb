class Info < ApplicationRecord
  include Publishable

  belongs_to :main_event, optional: true
  mount_uploader :image, ImageUploader

  after_initialize do
    self.created_at ||= Time.current
  end
end
