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

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(author_id: params[:user_id], title: params[:title], text: params[:text])
    redirect_back(fallback_location: root_path)
    flash.alert = if @post.save
                    'Comment posted...'
                  else
                    'Comment failed...'
                  end
  end

  def edit; end

  def update; end

  private

  def user_params
    params.require(:post).permit(:title, :text)
  end
end
