class LikesController < ApplicationController
  before_action :require_login

  def create
    @post = Post.find(params[:post_id])
    current_user.like(@post)
    UserMailer.with(user_from: current_user, user_to: @post.user, post: @post).like_post.delivery_later
  end

  def destroy
    @post = Like.find(params[:id]).post
    current_user.unlike(@post)
  end
end
