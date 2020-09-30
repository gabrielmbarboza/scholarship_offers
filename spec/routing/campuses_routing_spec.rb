require "rails_helper"

RSpec.describe CampusesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/campuses").to route_to("campuses#index")
    end

    it "routes to #show" do
      expect(get: "/campuses/1").to route_to("campuses#show", id: "1")
    end


    it "routes to #create" do
      expect(post: "/campuses").to route_to("campuses#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/campuses/1").to route_to("campuses#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/campuses/1").to route_to("campuses#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/campuses/1").to route_to("campuses#destroy", id: "1")
    end
  end
end
