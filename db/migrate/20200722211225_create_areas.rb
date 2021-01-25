class CreateAreas < ActiveRecord::Migration[6.0]
  def change
    create_table :areas do |t|
      t.string :areas_name
      t.references :prefecture, null: false, foreign_key: true

      t.timestamps
    end
  end
end
