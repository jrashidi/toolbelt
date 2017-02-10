class Photo < ApplicationRecord
  belongs_to :tool


  has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }
  validates_attachment_content_type :image, content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"]
end
