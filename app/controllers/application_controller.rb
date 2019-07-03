class ApplicationController < ActionController::Base
  helper_method :signed_in?, :current_user, :current_users_follows

  # after_action :last_seen

  private

  # Get signed user
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  # Returns an array of user ids.
  def current_users_follows
    if signed_in?
      current_users_follows = []
      current_user.follows.each do |follow|
        current_users_follows.push(follow.followed_id)
      end
      current_users_follows
    end
  end

  # Returns signed in.
  def signed_in?
    current_user
  end

#  def last_seen
#    if signed_in?
#      user = current_user
#      user.touch
#    end
#  end

end
