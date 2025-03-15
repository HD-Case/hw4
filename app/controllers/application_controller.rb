class ApplicationController < ActionController::Base
  before_action :current_user

  def current_user
    @current_user = User.find_by({ "id" => session["user_id"] })
  end

  def require_login
    unless current_user
      flash[:notice] = "Please login first."
      redirect_to "/login"
    end
  end
end
