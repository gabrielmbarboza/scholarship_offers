FactoryBot.define do
  factory :jwt_denylist do
    jti { "MyString" }
    exp { "2020-10-07 00:00:36" }
  end
end
