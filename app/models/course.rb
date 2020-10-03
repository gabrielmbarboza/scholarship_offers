class Course < ApplicationRecord
  belongs_to :university
  belongs_to :campus

  validates :name, presence: true
  validates :kind, presence: true
  validates :level, presence: true
  validates :shift, presence: true

  def self.search(kind: nil, level: nil, shift: nil,
                  university_name: nil, page: nil, per_page: 15)
    with_kind(kind)
      .with_level(level)
      .with_shift(shift)
      .with_university_name(university_name)
      .with_paginate(page, per_page)
  end

  scope :with_kind, -> (kind) {
    where(kind: kind) if kind.present?
  }

  scope :with_level, -> (level) {
    where(level: level) if level.present?
  }

  scope :with_shift, -> (shift) {
    where(shift: shift) if shift.present?
  }

  scope :with_university_name, -> (university_name) {
    includes(:university).where(universities: { name: university_name }) if university_name.present?
  }

  scope :with_paginate, -> (page, per_page) {
    if page.present? && per_page.present?
      paginate(page: page, per_page: per_page)
    end
  }
end
