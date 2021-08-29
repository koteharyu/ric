class CommentsController < ApplicationController
  before_action :require_login, only: [:creat, :edit, :update, :destroy]

  def create
    @comment = current_user.comments.create(comment_params)
  end

  def edit
    @comment = current_user.comments.find(params[:id])
  end

  def update
    @comment = current_user.comments.find(params[:id])
    @comment.update(update_comment_params)
  end

  def destroy
    @comment = current_user.comments.find(params[:id])
    @comment.destroy!
  end

  private

  def comment_params
    params.require(:comment).permit(:body).merge(post_id: params[:post_id])
  end

  def update_comment_params
    params.require(:comment).permit(:body)
  end
end
