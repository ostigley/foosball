class AddConfirmedToWinner < ActiveRecord::Migration[5.1]
  def change
    add_column :winners, :confirmed, :boolean, default: false
  end
end
