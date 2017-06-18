FactoryGirl.define do
  factory :player do
    sequence :name do |n|
      "#{Faker::Name.name}#{n}"
    end

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
