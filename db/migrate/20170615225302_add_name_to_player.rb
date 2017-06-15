class AddNameToPlayer < ActiveRecord::Migration[5.1]
  def change
    add_column :players, :name, :string
    add_column :players, :image, :string
  end
end
