class MainEvent < ApplicationRecord
  include Publishable
  mount_uploader :logo, ImageUploader

  has_many :event_schedules, -> { order(begin_time: :asc) }

  scope :begin_asc, -> { order(begin_time: :asc) }
  scope :begin_desc, -> { order(begin_time: :desc) }

  after_initialize do
    self.begin_time ||= Time.current
    self.end_time ||= Time.current
  end
end
