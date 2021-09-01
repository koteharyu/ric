class UsersController < ApplicationController
  def index
    @users = User.all.page(params[:page]).order(created_at: :desc)
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      auto_login(@user)
      redirect_to login_path, success: 'ようこそ'
    else
      flash.now[:danger] = 'もう一度やって'
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :username, :password, :password_confirmation, :avatar)
  end
end
