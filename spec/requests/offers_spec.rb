require 'rails_helper'

RSpec.describe "/offers", type: :request do
  let(:course) { create(:course) }

  let(:valid_attributes) {
    attributes_for(:offer, course_id: course.id)
  }

  let(:invalid_attributes) {
    attributes_for(:offer, full_price: nil)
  }

  # This should return the minimal set of values that should be in the headers
  # in order to pass any filters (e.g. authentication) defined in
  # OffersController, or in your router and rack
  # middleware. Be sure to keep this updated too.
  let(:valid_headers) {
    {}
  }

  describe "GET /index" do
    it "renders a successful response" do
      Offer.create! valid_attributes
      get offers_url, headers: valid_headers, as: :json
      expect(response).to be_successful
    end

    context "with search params" do
      it "search by university name" do
        offer1 = create(:offer)
        get offers_url, params: { university_name: offer1.course.university.name }
       
        offer_response = JSON.parse(response.body).first
        
        expect((offer_response["full_price"]).to_f).to eq(offer1.full_price.to_f)
      end

      it "search by campus city" do
        offer1 = create(:offer)
        get offers_url, params: { campus_city: offer1.course.campus.city }
        
        offer_response = JSON.parse(response.body).first
        
        expect((offer_response["full_price"]).to_f).to eq(offer1.full_price.to_f)
      end
    
      it "search by course name" do
        offer1 = create(:offer)
        get offers_url, params: { course_name: offer1.course.name }
        
        offer_response = JSON.parse(response.body).first
        
        expect((offer_response["full_price"]).to_f).to eq(offer1.full_price.to_f)
      end

      it "search by course kind" do
        offer1 = create(:offer)
        get offers_url, params: { course_kind: offer1.course.kind }
        
        offer_response = JSON.parse(response.body).first
        
        expect((offer_response["full_price"]).to_f).to eq(offer1.full_price.to_f)
      end

      it "search by course level" do
        offer1 = create(:offer)
        get offers_url, params: { course_level: offer1.course.level }
        
        offer_response = JSON.parse(response.body).first
        
        expect((offer_response["full_price"]).to_f).to eq(offer1.full_price.to_f)
      end

      it "search by course shift" do
        offer1 = create(:offer)
        get offers_url, params: { course_shift: offer1.course.shift }
        
        offer_response = JSON.parse(response.body).first
        
        expect((offer_response["full_price"]).to_f).to eq(offer1.full_price.to_f)
      end
    end

    context "returns offers sorted by price_with_discount" do
      it "with ASC order" do
        create_list(:offer, 3)

        get offers_url, params: { sort_by: "price_with_discount", order_by: "ASC" }

        offers = JSON.parse(response.body)

        expect(offers.first["price_with_discount"]).to be < offers.second["price_with_discount"]
        expect(offers.second["price_with_discount"]).to be < offers.third["price_with_discount"]
      end

      it "with DESC order" do
        create_list(:offer, 3)

        get offers_url, params: { sort_by: "price_with_discount", order_by: "DESC" }

        offers = JSON.parse(response.body)

        expect(offers.first["price_with_discount"]).to be > offers.second["price_with_discount"]
        expect(offers.second["price_with_discount"]).to be > offers.third["price_with_discount"]
      end
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      offer = Offer.create! valid_attributes
      get offer_url(offer), as: :json
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Offer" do
        expect {
          post offers_url,
               params: { offer: valid_attributes }, headers: valid_headers, as: :json
        }.to change(Offer, :count).by(1)
      end

      it "renders a JSON response with the new offer" do
        post offers_url,
             params: { offer: valid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Offer" do
        expect {
          post offers_url,
               params: { offer: invalid_attributes }, as: :json
        }.to change(Offer, :count).by(0)
      end

      it "renders a JSON response with errors for the new offer" do
        post offers_url,
             params: { offer: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq("application/json")
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:course) { create(:course) }

      let(:new_attributes) {
        attributes_for(:offer, course_id: course.id)
      }

      it "updates the requested offer" do
        offer = Offer.create! valid_attributes
        patch offer_url(offer),
              params: { offer: new_attributes }, headers: valid_headers, as: :json
        offer.reload
        expect((offer.full_price).to_f).to be == (new_attributes[:full_price]).to_f
        expect((offer.price_with_discount).to_f).to be == (new_attributes[:price_with_discount]).to_f
        expect((offer.discount_percentage).to_f).to be == (new_attributes[:discount_percentage]).to_f
        expect(offer.enrollment_semester).to eq(new_attributes[:enrollment_semester])
        expect(offer.start_date).to eq(new_attributes[:start_date])
        expect(offer.enabled).to eq(new_attributes[:enabled])
        expect(offer.course.id).to eq(new_attributes[:course_id])
      end

      it "renders a JSON response with the offer" do
        offer = Offer.create! valid_attributes
        patch offer_url(offer),
              params: { offer: new_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq("application/json")
      end
    end

    context "with invalid parameters" do
      it "renders a JSON response with errors for the offer" do
        offer = Offer.create! valid_attributes
        patch offer_url(offer),
              params: { offer: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq("application/json")
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested offer" do
      offer = Offer.create! valid_attributes
      expect {
        delete offer_url(offer), headers: valid_headers, as: :json
      }.to change(Offer, :count).by(-1)
    end
  end
end
