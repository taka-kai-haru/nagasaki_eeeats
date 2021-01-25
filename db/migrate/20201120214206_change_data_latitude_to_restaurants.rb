class ChangeDataLatitudeToRestaurants < ActiveRecord::Migration[6.0]
  def change
    change_column  :restaurants, :latitude, :decimal, default: 0,  precision: 10, scale: 6
    change_column  :restaurants, :longitude, :decimal, default: 0,  precision: 10, scale: 6
  end
end
