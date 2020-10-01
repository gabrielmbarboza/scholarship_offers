class Course < ApplicationRecord
  belongs_to :university
  belongs_to :campus

  validates :name, presence: true
  validates :kind, presence: true
  validates :level, presence: true
  validates :shift, presence: true
end
