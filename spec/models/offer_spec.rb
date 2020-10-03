require 'rails_helper'

RSpec.describe Offer, type: :model do
  let(:offer1) { create(:offer) }

  it "Should be valid" do
    expect(offer1).to be_valid
  end

  it "Should be valid, price_with_dicount must be less than full_price" do
    offer2 = build(:offer)
    expect(offer2.price_with_discount).to be < offer2.full_price
  end

  it "Should be valid, offer is enabled" do
    offer2 = build(:offer, enabled: true)
    expect(offer2.enabled).to be true
  end

  it "Should be valid, offer is disabled" do
    offer2 = build(:offer, enabled: false)
    expect(offer2.enabled).to be false
  end

  it "Should not be valid, full_price is not present" do
    offer2 = build(:offer, full_price: nil)
    expect(offer2).to_not be_valid
  end

  it "Should not be valid, course is not present" do
    offer2 = build(:offer, course: nil)
    expect(offer2).to_not be_valid
  end

  context "Uses the search method" do
    it "Should be return offer by university name" do
      offer = Offer.search(university_name: offer1.course.university.name).first
      expect(offer.id).to eq(offer1.id)
    end

    it "Should be return offer by campus city" do
      offer = Offer.search(campus_city: offer1.course.campus.city).first
      expect(offer.id).to eq(offer1.id)
    end

    it "Should be return offer by course name" do
      offer = Offer.search(course_name: offer1.course.name).first
      expect(offer.id).to eq(offer1.id)
    end

    it "Should be return offer by course kind" do
      offer = Offer.search(course_kind: offer1.course.kind).first
      expect(offer.id).to eq(offer1.id)
    end

    it "Should be return offer by course level" do
      offer = Offer.search(course_level: offer1.course.level).first
      expect(offer.id).to eq(offer1.id)
    end

    it "Should be return offer by course shift" do
      offer = Offer.search(course_shift: offer1.course.shift).first
      expect(offer.id).to eq(offer1.id)
    end

    it "Should sort offer by price_with_discount ordered by ASC" do
      create_list(:offer, 3)
      offers1 = Offer.search(sort_by: "price_with_discount", order_by: "asc")

      expect(offers1.first.price_with_discount).to be < offers1.second.price_with_discount
      expect(offers1.second.price_with_discount).to be < offers1.third.price_with_discount
    end

    it "Should sort offer by price_with_discount ordered by DESC" do
      create_list(:offer, 3)
      offers2 = Offer.search(sort_by: "price_with_discount", order_by: "desc")

      expect(offers2.first.price_with_discount).to be > offers2.second.price_with_discount
      expect(offers2.second.price_with_discount).to be > offers2.third.price_with_discount
    end
  end
end
