# class UsersController < ApplicationController
#   def index
#     @user = User.all
#     @posts = Post.all
#   end

#   def show
#     @total_posts = Post.where(author_id: params[:id]).count
#     @user = User.find(params[:id])
#     @recent_posts = Post.limit(2).where(author_id: params[:id]).order(created_at: :desc)
#     @comments = Comment.all
#     @likes = Like.all
#   end

#   def edit
#     @user = User.includes(:posts).find(params[:user_id])
#   end
# end

class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    user_signed_in?
    current_user
    user_session
    @user = User.all
    @posts = Post.all
  end

  def show
    @likes = Like.all.includes(:post_id)
    @comments = Comment.all.includes(:post_id).order(created_at: :desc)
    @user = User.find_by(id: params[:id])
  end
end
