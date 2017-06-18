FactoryGirl.define do
  factory :player do
    name  Faker::Name.unique.name
    sequence :email do |n|
      "person#{n}@example.com"
    end
    image Faker::Internet.url
    provider Faker::Name.name
    teams []
  end
end
