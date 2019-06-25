class ApplicationController < ActionController::Base
  helper_method :signed_in?, :current_user

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def signed_in?
    current_user
  end

end
