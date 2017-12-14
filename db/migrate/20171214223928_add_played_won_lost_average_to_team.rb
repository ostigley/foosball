class AddPlayedWonLostAverageToTeam < ActiveRecord::Migration[5.1]
  def change
    add_column :teams, :played, :integer
    add_column :teams, :won, :integer
    add_column :teams, :lost, :integer
    add_column :teams, :average, :float
  end
end
