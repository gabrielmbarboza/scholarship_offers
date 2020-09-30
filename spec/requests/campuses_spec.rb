require 'rails_helper'

RSpec.describe "/campuses", type: :request do
  let(:valid_attributes) {
    attributes_for(:campus)
  }

  let(:invalid_attributes) {
    attributes_for(:campus, name: nil)
  }

  # This should return the minimal set of values that should be in the headers
  # in order to pass any filters (e.g. authentication) defined in
  # CampusesController, or in your router and rack
  # middleware. Be sure to keep this updated too.
  let(:valid_headers) {
    {}
  }

  describe "GET /index" do
    it "renders a successful response" do
      Campus.create! valid_attributes
      get campuses_url, headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      campus = Campus.create! valid_attributes
      get campus_url(campus), as: :json
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Campus" do
        expect {
          post campuses_url,
               params: { campus: valid_attributes }, headers: valid_headers, as: :json
        }.to change(Campus, :count).by(1)
      end

      it "renders a JSON response with the new campus" do
        post campuses_url,
             params: { campus: valid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Campus" do
        expect {
          post campuses_url,
               params: { campus: invalid_attributes }, as: :json
        }.to change(Campus, :count).by(0)
      end

      it "renders a JSON response with errors for the new campus" do
        post campuses_url,
             params: { campus: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq("application/json")
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        attributes_for(:campus)
      }

      it "updates the requested campus" do
        campus = Campus.create! valid_attributes
        patch campus_url(campus),
              params: { campus: new_attributes }, headers: valid_headers, as: :json
        campus.reload
        expect(campus.name).to eq(new_attributes[:name])
        expect(campus.city).to eq(new_attributes[:city])
      end

      it "renders a JSON response with the campus" do
        campus = Campus.create! valid_attributes
        patch campus_url(campus),
              params: { campus: new_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq("application/json")
      end
    end

    context "with invalid parameters" do
      it "renders a JSON response with errors for the campus" do
        campus = Campus.create! valid_attributes
        patch campus_url(campus),
              params: { campus: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq("application/json")
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested campus" do
      campus = Campus.create! valid_attributes
      expect {
        delete campus_url(campus), headers: valid_headers, as: :json
      }.to change(Campus, :count).by(-1)
    end
  end
end
