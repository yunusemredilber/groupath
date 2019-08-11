class ApplicationController < ActionController::Base
  helper_method :signed_in?, :current_user, :current_users_follows
  before_action :set_request_variant#, only: :show

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
      current_users_follows || []
    end
  end

  # Returns signed in.
  def signed_in?
    current_user
  end

  # Sets Action Pack variant(s) depending on the browser/device/app or whatever
  def set_request_variant
    request.variant = :mobile if request.user_agent =~ /android|Android|blackberry|iphone|ipod|iemobile|mobile|webos/
    request.variant = :android_app if request.user_agent =~ /AndroidApp/
    puts "--------------"+request.variant.to_s+"--------------"
  end

#  def last_seen
#    if signed_in?
#      user = current_user
#      user.touch
#    end
#  end

end
