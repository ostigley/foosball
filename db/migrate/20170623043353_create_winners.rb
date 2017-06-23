class CreateWinners < ActiveRecord::Migration[5.1]
  def change
    create_table :winners do |t|
      t.belongs_to :game, index: true
      t.belongs_to :team, index: true
      t.timestamps
    end
  end
end
