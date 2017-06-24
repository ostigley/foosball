FactoryGirl.define do
  factory :team do
    trait :full_team do
      before(:create) do |team|
        team.players = create_list(:player, 2)
      end
    end
  end
end
