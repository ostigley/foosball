class AddTokenToWinner < ActiveRecord::Migration[5.1]
  def change
    add_column :winners, :token, :string
  end
end
