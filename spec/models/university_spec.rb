require 'rails_helper'

RSpec.describe University, type: :model do
  let(:university1) { create(:university) }

  it "Should be valid" do
    expect(university1).to be_valid
  end

  it "Should not be valid, name is not present" do
    university2 = build(:university, name: nil)
    expect(university2).to_not be_valid
  end
end
