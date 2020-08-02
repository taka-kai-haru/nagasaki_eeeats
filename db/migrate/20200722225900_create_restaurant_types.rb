class CreateRestaurantTypes < ActiveRecord::Migration[6.0]
  def change
    create_table :restaurant_types do |t|
      t.string :name

      t.timestamps
    end
  end
end
