class InstructorsController < ApplicationController
  def index
    instructors = Instructor.all
    render json: instructors, status: :ok
  end

  def show
    instructor = find_instructor
    if instructor
      render json: instructor, except: [:created_at, :updated_at], status: :ok
    else
      render json: { errors: "Instructor not found" }, status: :not_found
    end
  end

  def create
    instructor = Instructor.create!(instructor_params)
    render json: instructor, status: :created
  rescue ActiveRecord::RecordInvalid => e
    render json: { errors: e.record.errors.messages }, status: :unprocessable_entity
  end

  def update
    instructor = find_instructor
    if instructor
      instructor.update!(instructor_params)
      render json: instructor, status: :ok
    else
      render json: { errors: "Instructor not found" }, status: :not_found
    end
  end

  def destroy
    instructor = find_instructor
    if instructor
      instructor.destroy
    else
      render json: { errors: "Instructor not found" }, status: :not_found
    end
  end

  private

  def instructor_params
    params.permit(:name)
  end

  def find_instructor
    Instructor.find(params[:id])
  end

end
