class Member < ApplicationRecord

  validates :first_name , :last_name,:membership_number, :date_of_birth, presence: true
  validates :membership_number , uniqueness: true

  belongs_to :cover
  belongs_to :location

  attr_accessor :logo_crop_x,:logo_crop_y, :logo_crop_h,:logo_crop_w

  include ImageUploader::Attachment(:image)
end
