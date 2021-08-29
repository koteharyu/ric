class CommentsController < ApplicationController

  def create
    @comment = current_user.comments.create(comment_params)
  end

  def edit

  end

  def update

  end

  def destroy

  end

  private

  def comment_params
    params.require(:comment).permit(:body).merge(post_id: params[:post_id])
  end
end
