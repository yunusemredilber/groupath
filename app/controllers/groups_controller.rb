class GroupsController < ApplicationController
  def new
    @group = Group.new
  end

  def index
  end

  def members
    @group = Group.find_by_groupname(params[:id])
  end

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

  def show
    @group = Group.find_by_groupname(params[:id])
  end

  def edit
    @group = Group.find_by_groupname(params[:id])
  end

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

  def destroy
    @group = Group.find_by_groupname(params[:id])
    @group.destroy
    flash[:success] = 'Group Deleted!'
    redirect_to profile_path(current_user)
  end

  def message
    @group = Group.find_by_groupname(params[:id])
    @message = Message.new
  end

  def message_view
    @group = Group.find_by_groupname(params[:id])
    @message = Message.find(params[:message_id])
  end

  def edit_message
    @group = Group.find_by_groupname(params[:id])
    @message = Message.find(params[:message_id])
  end

  private

  def group_params
    params.require(:group).permit!
  end
end
