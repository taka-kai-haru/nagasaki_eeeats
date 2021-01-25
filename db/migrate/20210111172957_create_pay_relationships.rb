class CreatePayRelationships < ActiveRecord::Migration[6.0]
  def change
    create_table :pay_relationships do |t|
      t.references :restaurant, null: false, foreign_key: true
      t.references :payment_method, null: false, foreign_key: true

      t.timestamps
    end
  end
end
