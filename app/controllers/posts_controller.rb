class PostsController < ApplicationController
  before_action :require_login, only: [:new, :create, :edit, :update, :destroy]

  def index
    @users = User.recent(5)
    @posts = if current_user
               current_user.feed.includes(:user).page(params[:page]).order(created_at: :desc)
             else
               Post.all.includes(:user).page(params[:page]).order(created_at: :desc)
             end
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to posts_path, success: '投稿に成功'
    else
      flash.now[:danger] = '投稿に失敗'
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments.includes(:user).order(created_at: :desc)
    @comment = Comment.new
  end

  def edit
    @post = current_user.posts.find(params[:id])
  end

  def update
    @post = current_user.posts.find(params[:id])
    if @post.update(post_params)
      redirect_to post_path(@post), success: '更新に成功'
    else
      flash.now[:danger] = '更新に失敗'
      render :edit
    end
  end

  def destroy
    @post = current_user.posts.find(params[:id])
    @post.destroy!
    redirect_to posts_path, success: '削除に成功'
  end

  private

  def post_params
    params.require(:post).permit(:body, images: [])
  end
end
