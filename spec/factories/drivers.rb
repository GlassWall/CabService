FactoryBot.define do
  factory :driver do
    name { Faker::Name.name }
    phone_number { Faker::Number.number(digits: 10) }
  	email { Faker::Internet.email }
    license_number { Faker::IDNumber.valid }
    car_number { Faker::IDNumber.valid }
  end
end