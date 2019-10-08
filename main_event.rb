class MainEvent < ApplicationRecord
  include Publishable
  mount_uploader :logo, ImageUploader
  scope :position_desc, -> { order(position: :desc) }
  scope :position_asc, -> { order(position: :asc) }

  has_many :event_schedules, -> { order(begin_time: :asc) }
  has_many :infos, -> { order(id: :desc) }

  scope :begin_asc, -> { order(begin_time: :asc) }
  scope :begin_desc, -> { order(begin_time: :desc) }

  after_initialize do
    self.begin_time ||= Time.current
    self.end_time ||= Time.current
  end

  before_create do
    self.position = MainEvent.position_desc.first&.position.to_f + 100000
  end

  def amap_navigation_url
    "https://uri.amap.com/navigation?to=#{amap_location},#{name}&src=kkapi&callnative=1"
  end
end
