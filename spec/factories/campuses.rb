FactoryBot.define do
  factory :campus do
    name { FFaker::Education.school_name }
    city { FFaker::Address.city }
  end
end
