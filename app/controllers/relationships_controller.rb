class RelationshipsController < ApplicationController
  before_action :require_login, only: [:create, :update]

  def create
    @user = User.find(params[:followed_id])
    current_user.follow(@user)
    if @user.notification_on_follow
      UserMailer.with(user_from: current_user, user_to: @user).follow.deliver_later
    end
  end

  def destroy
    @user = Relationship.find(params[:id]).followed
    current_user.unfollow(@user)
  end
end
