class AddPlayedWonLostAverageToPlayer < ActiveRecord::Migration[5.1]
  def change
    add_column :players, :played, :integer
    add_column :players, :won, :integer
    add_column :players, :lost, :integer
    add_column :players, :average, :float
  end
end
