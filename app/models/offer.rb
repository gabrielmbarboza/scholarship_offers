class Offer < ApplicationRecord
  belongs_to :course

  validates :full_price, presence: true

  def self.search(university_name: nil, course_name: nil, 
    campus_city: nil, course_kind: nil, course_level: nil, 
    course_shift: nil, page: nil, per_page: 15, sort_by: nil, order_by: nil)
    
    with_university_name(university_name)
      .with_course_name(course_name)
      .with_campus_city(campus_city)
      .with_course_kind(course_kind)
      .with_course_level(course_level)
      .with_course_shift(course_shift)
      .with_order(sort_by, order_by)
      .with_paginate(page, per_page)
  end

  scope :with_university_name, -> (university_name) {
    includes(course: :university)
    .where(courses: { universities: { name: university_name }}) if university_name.present?
  }

  scope :with_course_name, -> (course_name) {
    includes(:course).where(courses: { name: course_name }) if course_name.present?
  }

  scope :with_campus_city, -> (campus_city) {
    includes(course: :campus )
      .where(courses: { campuses: {city: campus_city }}) if campus_city.present?
  }

  scope :with_course_kind, -> (course_kind) {
    includes(:course).where(courses: { kind: course_kind }) if course_kind.present?
  }  

  scope :with_course_level, -> (course_level) {
    includes(:course).where(courses: { level: course_level }) if course_level.present?
  }

  scope :with_course_shift, -> (course_shift) {
    includes(:course).where(courses: { shift: course_shift }) if course_shift.present?
  }

  scope :with_order, -> (sort_by, order_by) {
    if sort_by.present? && column_names.include?(sort_by)
      order("#{ sort_by } #{ order_by&.upcase || "ASC" }") 
    end
  }

  scope :with_paginate, -> (page, per_page) {
    if page.present? && per_page.present?
      paginate(page: page, per_page: per_page)
    end
  }
end
