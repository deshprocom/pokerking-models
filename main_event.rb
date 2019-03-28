class MainEvent < ApplicationRecord
  include Publishable
  mount_uploader :logo, ImageUploader
  scope :position_desc, -> { order(position: :desc) }

  has_many :event_schedules, -> { order(begin_time: :asc) }
  has_many :infos, -> { order(id: :desc) }

  scope :begin_asc, -> { order(begin_time: :asc) }
  scope :begin_desc, -> { order(begin_time: :desc) }

  after_initialize do
    self.begin_time ||= Time.current
    self.end_time ||= Time.current
  end
end
