class CreateStudentAcademicYears < ActiveRecord::Migration[7.0]
  def change
    create_table :student_academic_years do |t|
      t.references :member, null: false, foreign_key: true
      t.references :location, null: false, foreign_key: true
      t.references :academic_year, null: false, foreign_key: true

      t.timestamps
    end
  end
end
