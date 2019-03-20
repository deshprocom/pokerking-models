class Info < ApplicationRecord
  include Publishable

  belongs_to :main_event, optional: true
  mount_uploader :image, ImageUploader

  scope :show_in_homepage, -> { where(only_show_in_event: false) }

  after_initialize do
    self.created_at ||= Time.current
  end
end
