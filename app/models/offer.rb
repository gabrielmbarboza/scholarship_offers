class Offer < ApplicationRecord
  belongs_to :course

  validates :full_price, presence: true
end
