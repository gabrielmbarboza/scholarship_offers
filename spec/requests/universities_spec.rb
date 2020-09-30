require 'rails_helper'

RSpec.describe "/universities", type: :request do
  let(:valid_attributes) {
    attributes_for(:university)
  }

  let(:invalid_attributes) {
    attributes_for(:university, name: nil)
  }
  
  let(:valid_headers) {
    {}
  }

  describe "GET /index" do
    it "renders a successful response" do
      University.create! valid_attributes
      get universities_url, headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      university = University.create! valid_attributes
      get university_url(university), as: :json
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new University" do
        expect {
          post universities_url,
               params: { university: valid_attributes }, headers: valid_headers, as: :json
        }.to change(University, :count).by(1)
      end

      it "renders a JSON response with the new university" do
        post universities_url,
             params: { university: valid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "does not create a new University" do
        expect {
          post universities_url,
               params: { university: invalid_attributes }, as: :json
        }.to change(University, :count).by(0)
      end

      it "renders a JSON response with errors for the new university" do
        post universities_url,
             params: { university: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq("application/json")
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        attributes_for(:university)
      }

      it "updates the requested university" do
        university = University.create! valid_attributes
        patch university_url(university),
              params: { university: new_attributes }, headers: valid_headers, as: :json
        university.reload
        expect(university.name).to eq(new_attributes[:name])
      end

      it "renders a JSON response with the university" do
        university = University.create! valid_attributes
        patch university_url(university),
              params: { university: new_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq("application/json")
      end
    end

    context "with invalid parameters" do
      it "renders a JSON response with errors for the university" do
        university = University.create! valid_attributes
        patch university_url(university),
              params: { university: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq("application/json")
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested university" do
      university = University.create! valid_attributes
      expect {
        delete university_url(university), headers: valid_headers, as: :json
      }.to change(University, :count).by(-1)
    end
  end
end
