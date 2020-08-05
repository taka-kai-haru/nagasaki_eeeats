class CreateEvaluations < ActiveRecord::Migration[6.0]
  def change
    create_table :evaluations do |t|
      t.references :post, null: false, foreign_key: true
      t.references :evaluation_type, null: false, foreign_key: true
      t.integer :score

      t.timestamps
    end
  end
end
