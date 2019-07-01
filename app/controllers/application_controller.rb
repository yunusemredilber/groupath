class ApplicationController < ActionController::Base
  helper_method :signed_in?, :current_user, :current_users_follows

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def current_users_follows
    if signed_in?
      current_users_follows = []
      current_user.follows.each do |follow|
        current_users_follows.push(follow.followed_id)
      end
      current_users_follows
    end
  end

  def signed_in?
    current_user
  end

end
