FactoryGirl.define do
  factory :player do
    name  Faker::Name.unique.name
    sequence :email do |n|
      "person#{n}@example.com"
    end
    sequence :uid do |n|
      n
    end
    image Faker::Internet.url
    provider 'github'
    teams []
  end
end
