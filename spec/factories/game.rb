FactoryGirl.define do
  factory :game do

    before(:create) do |game|
      game.teams = create_list(:team, 2, :full_team)
    end
  end
end
