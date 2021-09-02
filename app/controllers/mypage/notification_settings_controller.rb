class Mypage::NotificationSettingsController < ApplicationController

  def edit
    @user = User.find(current_user.id)
  end

  def update
    @user = User.find(current_user.id)
    if @user.update(setting_params)
      redirect_to edit_mypage_notification_settings_path, success: "通知設定完了"
    else
      flash.now[:danger] = "通知設定に失敗"
      render :edit
    end
  end

  private

  def setting_params
    params.require(:user).permit(:notification_on_comment, :notification_on_like, :notification_on_follow)
  end
end
