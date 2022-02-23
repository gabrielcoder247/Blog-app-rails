class UsersController < ApplicationController
  def index
    @user = User.all
    @posts = Post.all
  end

  def show
    Post.all.each do |post|
      post.update(CommentsCounter: Comment.where(post_id: post.id).count)
      post.update(likes_counter: Like.where(posts_id: post.id).count)
    end
    @total_posts = Post.all.where(author_id: params[:id]).count
    @likes = Like.all
    @comments = Comment.all.order(created_at: :desc)
    @user = User.find_by(id: params[:id])
  end
end