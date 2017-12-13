class AddEloRankingToPlayers < ActiveRecord::Migration[5.1]
  def change
    add_column :players, :elo_ranking, :integer, default: 1400
  end
end
