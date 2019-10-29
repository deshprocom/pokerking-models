class UserExtra < ApplicationRecord
  mount_uploader :img_front, ImageUploader
  belongs_to :user, optional: true

  def image_path
    return '' if img_front.url.nil?

    img_front.url
  end
end
