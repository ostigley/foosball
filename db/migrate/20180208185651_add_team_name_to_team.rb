class AddTeamNameToTeam < ActiveRecord::Migration[5.1]
  def change
    add_column :teams, :identifier, :string
  end
end
