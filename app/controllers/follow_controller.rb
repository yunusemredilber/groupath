class FollowController < ApplicationController

  def create
    @followed = User.find(params[:id])
    if signed_in? && @followed
      if current_user.id == @followed.id
        flash[:error] = 'Don\'t try to follow yourself!'
        redirect_to profile_path(current_user)
      else
        follow = Follow.new(follower_id: current_user.id, followed_id: @followed.id)
        if follow.save
          flash[:success] = 'Followed!'
          redirect_to profile_path(@followed)
        else
          flash[:error] = 'Something wrong!'
          redirect_to profile_path(@followed)
        end
      end
    else
      flash[:notice] = 'You need to login and follow a valid user!'
      redirect_to '/'
    end
  end

  def destroy
    @followed = User.find(params[:id])
    if signed_in? && @followed
      follow = Follow.find_by(follower_id: current_user.id, followed_id: @followed.id)
      if follow.destroy
        flash[:success] = 'Unfollowed!'
        redirect_to profile_path(@followed)
      else
        flash[:error] = 'Something wrong!'
        redirect_to profile_path(@followed)
      end
    else
      flash[:notice] = 'You need to login and follow a valid user!'
      redirect_to '/'
    end
  end
end
