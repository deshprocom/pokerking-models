class EventInfo < ApplicationRecord
  include Publishable

  mount_uploader :image, ImageUploader

  belongs_to :main_event

  after_initialize do
    self.created_at ||= Time.current
  end
end
