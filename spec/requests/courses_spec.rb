require 'rails_helper'

RSpec.describe "/courses", type: :request do
  let(:university) { create(:university) }
  let(:campus) { create(:campus) }
  
  let(:valid_attributes) {
    attributes_for(:course, university_id: university.id, campus_id: campus.id)
  }

  let(:invalid_attributes) {
    attributes_for(:course, name: nil, kind: nil, level: nil, shift: nil)
  }

  let(:valid_headers) {
    {}
  }

  describe "GET /index" do
    it "renders a successful response" do
      Course.create! valid_attributes
      get courses_url, headers: valid_headers, as: :json
      expect(response).to be_successful
    end

    context "with search params" do
      it "search by university name" do
        course1 = create(:course)
        get courses_url, params: { university_name: course1.university.name }
        
        course_response = JSON.parse(response.body).first
        
        expect(course_response["name"]).to eq(course1.name)
      end

      it "search by course name" do
        course1 = create(:course)
        get courses_url, params: { name: course1.name }
        
        course_response = JSON.parse(response.body).first
        
        expect(course_response["name"]).to eq(course1.name)
      end

      it "search by course kind" do
        course1 = create(:course)
        get courses_url, params: { kind: course1.kind }
        
        course_response = JSON.parse(response.body).first
        
        expect(course_response["name"]).to eq(course1.name)
      end

      it "search by course level" do
        course1 = create(:course)
        get courses_url, params: { level: course1.level }
        
        course_response = JSON.parse(response.body).first
        
        expect(course_response["name"]).to eq(course1.name)
      end

      it "search by course shift" do
        course1 = create(:course)
        get courses_url, params: { shift: course1.shift }
        
        course_response = JSON.parse(response.body).first
        
        expect(course_response["name"]).to eq(course1.name)
      end
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      course = Course.create! valid_attributes
      get course_url(course), as: :json
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Course" do
        expect {
          post courses_url,
               params: { course: valid_attributes }, headers: valid_headers, as: :json
        }.to change(Course, :count).by(1)
      end

      it "renders a JSON response with the new course" do
        post courses_url,
             params: { course: valid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Course" do
        expect {
          post courses_url,
               params: { course: invalid_attributes }, as: :json
        }.to change(Course, :count).by(0)
      end

      it "renders a JSON response with errors for the new course" do
        post courses_url,
             params: { course: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq("application/json")
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:university) { create(:university) }
      let(:campus) { create(:campus) }
      
      let(:new_attributes) {
        attributes_for(:course, university_id: university.id, campus_id: campus.id)
      }

      it "updates the requested course" do
        course = Course.create! valid_attributes
        patch course_url(course),
              params: { course: new_attributes }, headers: valid_headers, as: :json
        course.reload
        expect(course.name).to eq(new_attributes[:name])
        expect(course.kind).to eq(new_attributes[:kind])
        expect(course.level).to eq(new_attributes[:level])
        expect(course.shift).to eq(new_attributes[:shift])
        expect(course.university.id).to eq(new_attributes[:university_id])
        expect(course.campus.id).to eq(new_attributes[:campus_id])
      end

      it "renders a JSON response with the course" do
        course = Course.create! valid_attributes
        patch course_url(course),
              params: { course: new_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq("application/json")
      end
    end

    context "with invalid parameters" do
      it "renders a JSON response with errors for the course" do
        course = Course.create! valid_attributes
        patch course_url(course),
              params: { course: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq("application/json")
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested course" do
      course = Course.create! valid_attributes
      expect {
        delete course_url(course), headers: valid_headers, as: :json
      }.to change(Course, :count).by(-1)
    end
  end
end
