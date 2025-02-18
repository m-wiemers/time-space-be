FactoryBot.define do
  factory :corporation do
    name { Faker::Company::name }
    location { Faker::Address::city }
  end
end
