class HomepageBanner < ApplicationRecord
  mount_uploader :image, ImageUploader
  validates :source_type, presence: true
  validates :source_id, presence: true
  validates :image, presence: true, if: :new_record?
  scope :position_desc, -> { order(position: :desc).order(id: :desc) }
  has_paper_trail

  before_create do
    self.position = HomepageBanner.position_desc.first&.position.to_f + 100000
  end

  def source
    @source ||= source_id && source_type.classify.safe_constantize.find(source_id)
  end

  def source_title
    return if source.nil?

    source.title
  end
end