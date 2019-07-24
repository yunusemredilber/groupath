class MessagesController < ApplicationController

  # Create message
  def create
    message = Message.new
    message[:subject] = message_params[:subject]
    message[:text] = message_params[:text]
    group = Group.find_by_groupname(message_params[:group])
    if group && signed_in?
      if group.users.include?(current_user) || group.admin_id == current_user.id
        message.group = group
        message.user = current_user
        if message.save
          group.users.each do |user|
            ActionCable.server.broadcast("notifications_#{user.channel}",
                                         html: html(message)
            )
          end
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

  # Update a message
  def update
    @message = Message.find(params[:id])
    update_params = message_params
    if update_params.has_key?(:user_id)
      flash[:notice] = 'Don\'t'
      redirect_to profile_path(current_user)
    else
      if @message.update_columns(subject: update_params[:subject],
                               text: update_params[:text]
      )
        @message.touch
        flash[:success] = 'Message Updated!'
        group = Group.find_by_groupname(message_params[:group])
        redirect_back fallback_location: '/'
      else
        flash[:notice] = 'An error occurred.'
      end
    end
  end

  # Destroy a message
  def destroy
    message = Message.find(params[:message_id])
    if signed_in? && current_user.messages.include?(message)
      if message.destroy
        flash[:success] = 'Message Deleted!'
        redirect_to group_path(params[:group_id])
      else
        flash[:notice] = 'An error occurred.'
        redirect_back fallback_location: '/'
      end
    end
  end

  private

  def message_params
    params.require(:message).permit(:subject, :text, :group)
  end

  def html(message)
    ApplicationController.render(partial: 'welcome/message', locals: { message: message, date: message.created_at })
  end

end
