class InfoTagRelation < ApplicationRecord
  belongs_to :info
  belongs_to :info_tag
end
