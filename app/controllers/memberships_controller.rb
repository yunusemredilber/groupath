class MembershipsController < ApplicationController

  # Create membership
  def create
    group = Group.find(params[:id])
    if signed_in? && group
      membership = Membership.new(user: current_user, group: group, active: false)
      if membership.save
        flash[:success] = 'Joined!'
        redirect_to group_path(group)
      else
        puts membership.errors.inspect
        flash[:error] = 'An error occurred.'
        redirect_back(fallback_location: '/')
      end
    else
      flash[:error] = 'Please make sure of you are signed and try to join an existing group.'
      redirect_back(fallback_location: '/')
    end
  end

  # Destroy a membership
  def destroy
    group = Group.find(params[:id])
    if signed_in? && group
      membership = Membership.find_by(user_id: current_user.id, group_id: group.id)
      if membership.destroy
        flash[:success] = 'Quited Successfully.'
        redirect_to group_path(group)
      else
        flash[:error] = 'An error occurred!'
      end
    end
  end
end
