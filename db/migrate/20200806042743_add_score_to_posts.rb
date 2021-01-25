class AddScoreToPosts < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :atmosphere, :integer ,default: 3, null: false
    add_column :posts, :accessibility, :integer, default: 3, null: false
    add_column :posts, :cost_performance, :integer ,default: 3, null: false
    add_column :posts, :assortment, :integer, default: 3, null: false
    add_column :posts, :service, :integer, default: 3, null: false
    add_column :posts, :delicious, :integer, default: 3, null: false
  end
end
