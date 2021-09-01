class Mypage::NotificationsController < Mypage::BaseController

  def index
    @notifications = current_user.notifications
  end
end
