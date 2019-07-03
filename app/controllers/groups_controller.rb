class GroupsController < ApplicationController

  # New group page
  def new
    @group = Group.new
  end

  # Members page
  def members
    @group = Group.find_by_groupname(params[:id])
  end

  # Create a new group
  def create
    group_params[:admin_id] = current_user.id
    @group = Group.new(group_params)
    if @group.save
      flash[:notice] = 'Let\'s invite some users!'
      redirect_to group_path(@group)
    else
      flash[:error] = 'An error occurred!'
      render :new
    end
  end

  # Show a group page
  def show
    @group = Group.find_by_groupname(params[:id])
    unless @group
      render 'users/not_found_page'
    end
  end

  # Edit a group page
  def edit
    @group = Group.find_by_groupname(params[:id])
  end

  # Update a group
  def update
    @group = Group.find_by_groupname(params[:id])
    update_params = group_params
    if update_params.has_key?(:admin_id)
      flash[:notice] = 'How dare you!'
      update_params.delete(:admin_id)
    end
    if @group.update_columns(groupname: update_params[:groupname],
                            title: update_params[:title],
                            description: update_params[:description]
                            )
      flash[:success] = 'Group Updated!'
      redirect_to group_path(@group)
    else
      flash[:notice] = 'An error occurred.'
    end
  end

  # Delete a group
  def destroy
    @group = Group.find_by_groupname(params[:id])
    @group.destroy
    flash[:success] = 'Group Deleted!'
    redirect_to profile_path(current_user)
  end

  # New message page
  def message
    @group = Group.find_by_groupname(params[:id])
    @message = Message.new
    unless @group
      render 'users/not_found_page'
    end
  end

  # Message view page
  def message_view
    @group = Group.find_by_groupname(params[:id])
    @message = Message.find(params[:message_id])
    @comment = Comment.new
    unless @group
      render 'users/not_found_page'
    end
  end

  # Edit message page
  def edit_message
    @group = Group.find_by_groupname(params[:id])
    @message = Message.find(params[:message_id])
    unless @group
      render 'users/not_found_page'
    end
  end

  private

  def group_params
    params.require(:group).permit!
  end
end
