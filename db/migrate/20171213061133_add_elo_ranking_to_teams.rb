class AddEloRankingToTeams < ActiveRecord::Migration[5.1]
  def change
    add_column :teams, :elo_ranking, :float, default: 10**(2000/400)
  end
end
