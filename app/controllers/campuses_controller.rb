class CampusesController < ApplicationController
  before_action :set_campus, only: [:show, :update, :destroy]

  # GET /campuses
  def index
    @campuses = Campus.all

    render json: @campuses
  end

  # GET /campuses/1
  def show
    render json: @campus
  end

  # POST /campuses
  def create
    @campus = Campus.new(campus_params)

    if @campus.save
      render json: @campus, status: :created, location: @campus
    else
      render json: @campus.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /campuses/1
  def update
    if @campus.update(campus_params)
      render json: @campus
    else
      render json: @campus.errors, status: :unprocessable_entity
    end
  end

  # DELETE /campuses/1
  def destroy
    @campus.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_campus
      @campus = Campus.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def campus_params
      params.require(:campus).permit(:name, :city)
    end
end
