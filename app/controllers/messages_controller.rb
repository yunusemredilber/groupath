class MessagesController < ApplicationController

  def create
    message = Message.new
    message[:subject] = message_params[:subject]
    message[:text] = message_params[:text]
    group = Group.find_by_groupname(message_params[:group])
    if group && signed_in?
      if group.users.include? current_user
        message.group = group
        message.user = current_user
        if message.save
          flash[:success] = 'Message created successfully!'
          redirect_to group_path(group)
        else
          flash[:error] = 'Something went wrong.'
          redirect_to group_path(group)
        end
      else
        flash[:error] = 'You are NOT member of that group!'
        redirect_to group_path(group)
      end
    else
      flash[:error] = 'Please make sure of that group is exist and you are signed in.'
      render :'groups/message'
    end

  end

  private

  def message_params
    params.require(:message).permit!
  end

end
