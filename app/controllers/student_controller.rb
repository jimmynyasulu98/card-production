class StudentController < ApplicationController
  require 'csv'
  require 'creek'
  require 'zip'
  require 'fileutils'
  before_action :set_card, only: %i[index select_student_list select_student ]


  def index
    @students = {}
  end

  # GET /members/new
  def new_student_list

  end

  def create_student_list
    file = params[:file]
    return redirect_to student_new_student_list_path, notice: "CSV files only" unless
      file.content_type == "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"




    folder_name = params[:uploaded_file].original_filename.split(".").first
    Zip::File.open(params[:uploaded_file]) do |zip_file|
        zip_file.each do |f|

          f_path = File.join("public", f.name)
          FileUtils.mkdir_p(File.dirname(f_path))
          zip_file.extract(f, f_path) unless File.exist?(f_path)
        end
    end

    cover = Cover.find_by(name: "Student").id
    location = Location.find(params[:location])

    creek = Creek::Book.new(file)
    sheet = creek.sheets[0]
    sheet.rows.each do |row|
      user_hash = {}
      student_academic_year_hash = {}
      user_hash[:first_name] = row.values[0]
      user_hash[:last_name] = row.values[1]
      user_hash[:membership_number] = "#{row.values[2]}-#{row.values[3]}-#{row.values[4]}-00"
      user_hash[:date_of_birth] = row.values[5]
      user_hash[:date_joined] = "02/02/2024"
      user_hash[:cover_id] = cover
      user_hash[:location_id] = student_academic_year_hash[:location_id] =  params[:location]
      student_academic_year_hash[:academic_year_id] = params[:academic_year]

      image_with_extention = Dir.entries("public/#{folder_name}").select { |f| f.include? "#{row.values[6]}" }[0]
      File.open(File.join("public/#{folder_name}", image_with_extention), 'r') do |f|
        user_hash[:image] = f
        member = Member.create(user_hash)
        student_academic_year_hash[:member_id] = member.id
        StudentAcademicYear.create(student_academic_year_hash)

      end
    end
    FileUtils.rm_rf("public/#{folder_name}")
  end

  def select_student_list
    @students = StudentAcademicYear.where(academic_year_id:params[:academic_year], location_id:params[:location])
    render :index
  end

  def select_student
    @student = StudentAcademicYear.find_by(member_id:params[:id])
    @students = StudentAcademicYear.where(academic_year_id:@student.academic_year_id,location_id:@student.location_id)

    render :index
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_card
    @card = Card.first()
  end

end
