
class PostsController < ApplicationController
  def index
    @params = params
    @user = User.find_by(id: params[:user_id])
    @posts = Post.all.where(author_id: params[:user_id])
    @comments = Comment.all
    @likes = Like.all
    Post.all.each do |post|
      post.update(CommentsCounter: Comment.where(post_id: post.id).count)
      post.update(likes_counter: Like.where(posts_id: post.id).count)
    end
  end

  def show
    @comments = Comment.all.order(created_at: :desc)
    @post = Post.find_by(author_id: params[:user_id], id: params[:id])
    @user = User.find_by(id: params[:user_id])
    @users = User.all
    @likes = Like.all
  end
end