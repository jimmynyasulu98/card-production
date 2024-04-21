class StudentAcademicYear < ApplicationRecord
  belongs_to :member
  belongs_to :location
  belongs_to :academic_year
end
