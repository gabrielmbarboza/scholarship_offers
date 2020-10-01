FactoryBot.define do
  factory :campus do
    name { Faker::Educator.campus }
    city { Faker::Address.city }
  end
end
