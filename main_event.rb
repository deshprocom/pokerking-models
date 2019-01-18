class MainEvent < ApplicationRecord
  include Publishable
  mount_uploader :logo, ImageUploader

  after_initialize do
    self.begin_time ||= Time.current
    self.end_time ||= Time.current
  end
end
