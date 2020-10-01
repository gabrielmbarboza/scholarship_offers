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
end
