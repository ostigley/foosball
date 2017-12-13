class AddEloRankingToTeams < ActiveRecord::Migration[5.1]
  def change
    add_column :teams, :elo_ranking, :integer, default: 1400
  end
end
