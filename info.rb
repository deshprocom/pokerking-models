class Info < ApplicationRecord
  include Publishable

  belongs_to :main_event, optional: true
  mount_uploader :image, ImageUploader
  has_many :info_tag_relations, dependent: :destroy
  has_many :info_tags, through: :info_tag_relations
  has_many :homepage_banners, as: :source, dependent: :destroy

  scope :show_in_homepage, -> { where(only_show_in_event: false) }
  scope :page_order, -> { order(position: :desc).order(id: :desc) }
  scope :hot, -> { where(hot: true) }

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
