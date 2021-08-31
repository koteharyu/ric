class ApplicationController < ActionController::Base
  add_flash_types :success, :info, :warning, :danger
  before_action :set_search_posts_form

  private

  def not_authenticated
    redirect_to login_path, danger: 'ログインしてね'
  end

  def set_search_posts_form
    @search_form = SearchPostsForm.new(search_post_params)
  end

  def search_post_params
    params.fetch(:q, {}).permit(:body)
  end
end
