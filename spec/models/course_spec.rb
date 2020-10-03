require 'rails_helper'

RSpec.describe Course, type: :model do
  let(:course1) { create(:course) }

  it "Should be valid" do
    expect(course1).to be_valid
  end

  it "Should not be valid, name is not present" do
    course2 = build(:course, name: nil)
    expect(course2).to_not be_valid
  end

  it "Should not be valid, kind is not present" do
    course2 = build(:course, kind: nil)
    expect(course2).to_not be_valid
  end

  it "Should not be valid, level is not present" do
    course2 = build(:course, level: nil)
    expect(course2).to_not be_valid
  end

  it "Should not be valid, shift is not present" do
    course2 = build(:course, shift: nil)
    expect(course2).to_not be_valid
  end

  it "Should not be valid, university is not present" do
    course2 = build(:course, university: nil)
    expect(course2).to_not be_valid
  end

  it "Should not be valid, campus is not present" do
    course2 = build(:course, campus: nil)
    expect(course2).to_not be_valid
  end

  context "Uses the search method" do
    it "Should be return course by university name" do
      course = Course.search(university_name: course1.university.name).first
      expect(course.id).to eq(course1.id)
    end

    it "Should be return course by course kind" do
      course = Course.search(kind: course1.kind).first
      expect(course.id).to eq(course1.id)
    end

    it "Should be return course by course level" do
      course = Course.search(level: course1.level).first
      expect(course.id).to eq(course1.id)
    end

    it "Should be return course by course shift" do
      course = Course.search(shift: course1.shift).first
      expect(course.id).to eq(course1.id)
    end
  end
end
