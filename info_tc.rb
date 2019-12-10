class InfoTc < ApplicationRecord
  belongs_to :info, foreign_key: 'id', optional: true
  mount_uploader :image, ImageUploader
  has_paper_trail

  before_save do
    diff_attrs = %w(title source description)
    assign_attributes info.reload.attributes.reject { |k| !attributes[k].nil? && k.in?(diff_attrs) }
  end
end