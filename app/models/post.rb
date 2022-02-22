class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :comments, foreign_key: 'posts_id'
  has_many :likes, foreign_key: 'posts_id'
  after_save :post_counter

  def five_recent_comments
    comment.limit(5).order(created_at: :desc)
  end

  private

  def post_counter
    author.increment!(:PostsCounter)
  end
end
