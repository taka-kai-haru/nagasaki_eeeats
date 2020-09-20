class AddLikesToPosts < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :likes, :boolean, default: false, null: false
    add_column :posts, :dislikes, :boolean, default: false, null: false
  end
end
