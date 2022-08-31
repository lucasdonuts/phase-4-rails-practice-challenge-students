class StudentsController < ApplicationController
  def index
    students = Student.all
    render json: students
  end

  def show
    student = find_student
    if student
      render json: student, except: [:created_at, :updated_at], status: :ok
    else
      render json: { errors: "Student not found" }, status: :not_found
    end
  end

  def create
    instructor = Instructor.find(params[:instructor_id])
    if instructor
      student = Student.create!(student_params)
      render json: student, status: :created
    else
      render json: { errors: "Instructor not found" }
    end
  rescue ActiveRecord::RecordInvalid => e
    render json: { errors: e.record.errors.messages }, status: :unprocessable_entity
  end

  def update
    student = find_student
    student.update!(student_params)
    render json: student, status: :ok
  rescue ActiveRecord::RecordInvalid => e
    render json: { errors: e.record.errors.messages }, status: :unprocessable_entity
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
end
