class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(author_id: current_user.id, text: comment_params[:text], post_id: params[:post_id])
    redirect_back(fallback_location: root_path)
    flash.alert = if @comment.save
                    'Comment posted...'
                  else
                    'Comment failed...'
                  end
  end

  def update; end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    @comment.destroy
    @post.comments_counter -= 1
    @post.save
    redirect_to("/users/#{current_user.id}/posts/#{@post.id}")
    flash[:success] = 'Comment was deleted!'
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
