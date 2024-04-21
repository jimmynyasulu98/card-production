class AcademicYear < ApplicationRecord
  validates :name ,presence: true, uniqueness: true
end
