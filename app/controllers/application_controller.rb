class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :require_login
  include ApplicationHelper

  private

  def require_login
    unless logged_in?
      flash[:alert] = "You must be logged in to access this section"
      redirect_to users_login_path
    end
  end

end
