module AvatarHelper
  def user_avatar_path(user)
    user.avatar.attached? ? url_for(user.avatar) : "62253.png"
  end

  def group_avatar_path(group)
    group.avatar.attached? ? url_for(group.avatar) : "59293.png"
  end
end
