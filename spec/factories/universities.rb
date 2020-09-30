FactoryBot.define do
  factory :university do
    name { FFaker::Education.school }
    score { rand(0.0 .. 100.0).ceil(2) }
    logo_url { FFaker::Image.url }
  end
end
