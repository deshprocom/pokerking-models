class InfoTag < ApplicationRecord
  has_many :info_tag_relations, dependent: :destroy
  has_many :infos, through: :info_tag_relations
  validates :name, presence: true
  validates :name_en, presence: true
end