class FollowController < ApplicationController

  # Follow an user.
  def create
    @followed = User.find(params[:id])
    if signed_in? && @followed
      if current_user.id == @followed.id
        flash[:error] = 'Don\'t try to follow yourself!'
        redirect_to profile_path(current_user)
      else
        follow = Follow.new(follower_id: current_user.id, followed_id: @followed.id)
        if follow.save
          ActionCable.server.broadcast("notifications_#{@followed.channel}",
                                       html: html(follow)
          )
          flash[:success] = 'Followed!'
          redirect_back(fallback_location: profile_path(@followed))
        else
          flash[:error] = 'Something wrong!'
          redirect_back(fallback_location: profile_path(@followed))
        end
      end
    else
      flash[:notice] = 'You need to login and follow a valid user!'
      redirect_back(fallback_location: '/')
    end
  end

  # Unfollow an user.
  def destroy
    @followed = User.find(params[:id])
    if signed_in? && @followed
      follow = Follow.find_by(follower_id: current_user.id, followed_id: @followed.id)
      if follow.destroy
        flash[:success] = 'Unfollowed!'
        redirect_back(fallback_location: profile_path(@followed))
      else
        flash[:error] = 'Something wrong!'
        redirect_back(fallback_location: profile_path(@followed))
      end
    else
      flash[:notice] = 'You need to login and follow a valid user!'
      redirect_back(fallback_location: '/')
    end
  end

  private

  def html(follow)
    ApplicationController.render(partial: 'welcome/follow', locals: { follow: follow, date: follow.created_at })
  end
end
