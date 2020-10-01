FactoryBot.define do
  factory :offer do
    full_price { Faker::Number.decimal(l_digits: 3, r_digits: 2)}
    price_with_discount { Faker::Number.decimal(l_digits: 2, r_digits: 2) }
    discount_percentage { Faker::Number.decimal(l_digits: 2, r_digits: 2) }
    start_date { Faker::Date.between(from: 15.days.ago, to: Date.today) }
    enrollment_semester { "#{ Date.current.year }.#{rand(1..2)}" }
    enabled { [true, false].sample }
    course
  end
end
