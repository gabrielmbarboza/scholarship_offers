class OffersController < ApplicationController
  before_action :set_offer, only: [:show, :update, :destroy]

  # GET /offers
  def index
    @offers = Offer.search(
      university_name: params[:university_name],
      course_name: params[:course_name],
      campus_city: params[:campus_city],
      course_kind: params[:course_kind],
      course_level: params[:course_level],
      course_shift: params[:course_shift],
      sort_by: params[:sort_by],
      order_by: params[:order_by],
      page: params[:page],
      per_page: params[:per_page]
    )
  end

  # GET /offers/1
  def show
    render json: @offer
  end

  # POST /offers
  def create
    @offer = Offer.new(offer_params)

    if @offer.save
      render json: @offer, status: :created, location: @offer
    else
      render json: @offer.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /offers/1
  def update
    if @offer.update(offer_params)
      render json: @offer
    else
      render json: @offer.errors, status: :unprocessable_entity
    end
  end

  # DELETE /offers/1
  def destroy
    @offer.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_offer
      @offer = Offer.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def offer_params
      params.require(:offer).permit(:full_price, :price_with_discount, :discount_percentage, 
        :start_date, :enrollment_semester, :enabled, :course_id)
    end
end
