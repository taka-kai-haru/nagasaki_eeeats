class AddClosedToRestaurants < ActiveRecord::Migration[6.0]
  def change
    add_column :restaurants, :closed, :boolean, default: false, null: false
  end
end
