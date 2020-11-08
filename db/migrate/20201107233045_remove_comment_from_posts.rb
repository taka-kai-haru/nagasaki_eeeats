class RemoveCommentFromPosts < ActiveRecord::Migration[6.0]
  def change
    remove_column :posts, :comment, :text
  end
end
