class CoursesController < ApplicationController
  before_action :set_course, only: [:show, :update, :destroy]

  # GET /courses
  def index
    @courses = Course.search(
      kind: params[:kind],
      level: params[:level],
      shift: params[:shift],
      university_name: params[:university_name],
      page: params[:page],
      per_page: params[:per_page]
    )
    if stale?(etag: @courses)
      render 'courses/index.json.jbuilder'
    end
  end

  # GET /courses/1
  def show
    if stale?(etag: @course)
      render 'courses/show.json.jbuilder'
    end
  end

  # POST /courses
  def create
    @course = Course.new(course_params)

    if @course.save
      render json: @course, status: :created, location: @course
    else
      render json: @course.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /courses/1
  def update
    if @course.update(course_params)
      render json: @course
    else
      render json: @course.errors, status: :unprocessable_entity
    end
  end

  # DELETE /courses/1
  def destroy
    @course.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def course_params
      params.require(:course).permit(:name, :kind, :level, :shift, :university_id, :campus_id)
    end
end
