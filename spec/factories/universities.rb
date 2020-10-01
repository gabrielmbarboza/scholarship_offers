FactoryBot.define do
  factory :university do
    name { Faker::Educator.university }
    score { Faker::Number.decimal(l_digits: 2) }
    logo_url { Faker::Avatar.image }
  end
end
