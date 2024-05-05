class StudentController < ApplicationController
  skip_before_action :verify_authenticity_token
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

    respond_to do |format|
      @student = StudentAcademicYear.find_by(member_id:params[:id])
      #setting student id and corresponding index on UI student list into session cookie to be accessed in AJAX call

      session[:student] = @student.member_id
      session[:index] = params[:index]
      #@students = StudentAcademicYear.where(academic_year_id:@student.academic_year_id,location_id:@student.location_id)
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace(:card_section , partial:"members/card_section" ,locals:{ member: @student.member, card: @card} )
      end
      format.html { render :index }
    end
  end

  def mark_printed
    puts session.to_hash
    puts params

    member = Member.find(session[:student])
    member.card_printed = true
    member.save
    @student = StudentAcademicYear.find_by(member_id: session[:student])


    respond_to do |format|

      format.turbo_stream do
        render  turbo_stream: turbo_stream.replace(:"student_#{@student.member_id}" ,
          partial: 'student', locals: { student: @student, index: session[:index], fade_in: true } )
      end

      format.html { render :index }
    end

  end


  private
  # Use callbacks to share common setup or constraints between actions.

  def set_card
    @card = Card.first()
  end

end
