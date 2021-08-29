class PostsController < ApplicationController

  def index
    @posts = Post.all.includes(:user)
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to posts_path, success: '投稿に成功'
    else
      flash.now[:danger] = "投稿に失敗"
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = current_user.posts.params[:id]
  end

  def update
    @post = current_user.posts.params[:id]
    if @post.update(post_params)
      redirect_to post_path(@post), success: '更新に成功'
    else
      flash.now[:danger] = "更新に失敗"
      render :edit
    end
  end

  def destroy
    @post = current_user.posts.params[:id]
    @post.destroy!
    redirect_to posts_path, success: '削除に成功'
  end

  private

  def post_params
    params.require(:post).permit(:body)
  end
end