FactoryBot.define do
  factory :course do
    name { FFaker::Education.major }
    kind { %w[In-class On-line].sample }
    level { FFaker::Education.degree }
    shift { %w[First\ shift Second\ shift Third\ shift].sample }
    university
    campus
  end
end
