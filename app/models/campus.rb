class Campus < ApplicationRecord
  validates :name, presence: true
  validates :city, presence: true
end
