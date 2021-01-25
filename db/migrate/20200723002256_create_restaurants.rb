class CreateRestaurants < ActiveRecord::Migration[6.0]
  def change
    create_table :restaurants do |t|
      t.references :area, null: false, foreign_key: true
      t.references :restaurant_type, null: false, foreign_key: true
      t.string :name, null: false
      t.string :tel, null: false
      t.string :url
      t.string :address, null: false

      t.timestamps
    end
  end
end
