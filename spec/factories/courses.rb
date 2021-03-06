FactoryBot.define do
  factory :course do
    name { Faker::Educator.subject }
    kind { %w[In-class On-line].sample }
    level { Faker::Educator.degree }
    shift { %w[First\ shift Second\ shift Third\ shift].sample }
    university
    campus
  end
end
