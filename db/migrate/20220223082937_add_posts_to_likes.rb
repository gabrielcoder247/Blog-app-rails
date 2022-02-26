class AddPostsToLikes < ActiveRecord::Migration[7.0]
  def change
    add_reference :likes, :posts, foreign_key: { to_table: :posts }
  end
end
