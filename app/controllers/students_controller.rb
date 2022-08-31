class StudentsController < ApplicationController
  def index
    students = Student.all
    render json: students, except: omitted, status: :ok
  end

  def show
    student = find_student
    render json: student, except: omitted, status: :ok
  end

  def create
    instructor = Instructor.find(params[:instructor_id])
    student = Student.create!(student_params)
    render json: student, status: :created
  end

  def update
    student = find_student
    student.update!(student_params)
    render json: student, status: :ok
  end

  def destroy
    student = find_student
    student.destroy
  end

  private

  def student_params
    params.permit(:name, :major, :age, :instructor_id)
  end
  
  def find_student
    Student.find(params[:id])
  end

  # def omitted
  #   [:created_at, :updated_at]
  # end
end
