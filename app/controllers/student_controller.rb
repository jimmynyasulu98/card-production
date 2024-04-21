class StudentController < ApplicationController
  require 'csv'
  require 'creek'

  def index
  end

  # GET /members/new
  def new_student_list

  end

  def create_student_list
    file = params[:file]
    return redirect_to student_new_student_list_path, notice: "CSV files only" unless
      file.content_type == "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"




    require 'zip'


    folder_name = params[:uploaded_file].original_filename.split(".").first
    Zip::File.open(params[:uploaded_file]) do |zip_file|
        zip_file.each do |f|

          f_path = File.join("public", f.name)
          FileUtils.mkdir_p(File.dirname(f_path))
          zip_file.extract(f, f_path) unless File.exist?(f_path)
        end
    end


    creek = Creek::Book.new(file)
    sheet = creek.sheets[0]
    sheet.rows.each do |row|
      puts row.values[1] # => {"A1"=>"Content 1", "B1"=>nil, "C1"=>nil, "D1"=>"Content 3"}
    end




  end

end
