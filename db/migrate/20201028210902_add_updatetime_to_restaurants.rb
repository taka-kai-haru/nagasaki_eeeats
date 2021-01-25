class AddUpdatetimeToRestaurants < ActiveRecord::Migration[6.0]
  def change
    add_column :restaurants, :updatetime, :datetime, precision: 6
  end
end
