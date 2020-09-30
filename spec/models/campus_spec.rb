require 'rails_helper'

RSpec.describe Campus, type: :model do
  let(:campus1) { create(:campus) }

  it "Should be valid" do
    expect(campus1).to be_valid
  end

  it "Should not be valid, name is not present" do
    campus2 = build(:campus, name: nil)
    expect(campus2).to_not be_valid
  end

  it "Should not be valid, city is not present" do
    campus2 = build(:campus, city: nil)
    expect(campus2).to_not be_valid
  end
end
