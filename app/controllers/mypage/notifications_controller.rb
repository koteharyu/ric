class Mypage::NotificationsController < Mypage::BaseController

  def index
    @notifications = current_user.notifications.recent(10)
  end
end
