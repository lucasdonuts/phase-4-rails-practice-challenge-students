class InstructorsController < ApplicationController
  def index
    instructors = Instructor.all
    render json: instructors, except: omitted, status: :ok
  end

  def show
    instructor = find_instructor
    render json: instructor, except: omitted, status: :ok
  end

  def create
    instructor = Instructor.create!(instructor_params)
    render json: instructor, status: :created
  end

  def update
    instructor = find_instructor
    instructor.update!(instructor_params)
    render json: instructor, status: :ok
  end

  def destroy
    instructor = find_instructor
    instructor.destroy
  end

  private

  def instructor_params
    params.permit(:name)
  end

  def find_instructor
    Instructor.find(params[:id])
  end

end
