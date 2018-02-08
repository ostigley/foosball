namespace :updateteamnames do
  task :generate => :environment do
    Team.all.each do |team|
      team.update_attribute(:identifier, team.generate_identifier)
    end
  end

  task :merge_duplicate_teams => :environment do
    duplicates = Team.select(:identifier).group(:identifier).having("count(*) > 1").to_ary
    duplicates.each do |duplicate|
      teams = Team.where(identifier: duplicate.identifier).to_a
      priority_team = teams.shift
      teams.each do |team|
        team.games.each do |game|
          priority_team.games << game
          priority_team.save!
        end
        priority_team.update_attributes({ won: priority_team.won.to_i + team.won.to_i,
                                          lost: priority_team.lost.to_i + team.lost.to_i,
                                          played: priority_team.played.to_i + team.played.to_i })
        team.destroy!

      end

    end
  end
end
