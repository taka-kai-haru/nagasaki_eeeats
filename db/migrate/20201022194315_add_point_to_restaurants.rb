class AddPointToRestaurants < ActiveRecord::Migration[6.0]
  def change
    add_column :restaurants, :point, :decimal
    add_column :restaurants, :accessinformation, :text
  end
end
