module AvatarHelper
  def user_avatar_path(user)
    user.avatar.attached? ? url_for(user.avatar) : "62253.png"
  end
end
