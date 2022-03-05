class RemovePostsCounterFromUsers < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :PostsCounter, :integer
  end
end
