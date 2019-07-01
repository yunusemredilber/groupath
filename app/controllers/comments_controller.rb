class CommentsController < ApplicationController

  def create
    comment = Comment.new
    comment[:text] = comment_params[:text]
    message = Message.find(comment_params[:message])
    if signed_in? && message
      if message.group.users.include?(current_user) || message.group.admin_id == current_user.id
        comment.user = current_user
        comment.message = message
        if comment.save
          flash[:success] = 'Thanks for u\'r comment.'
          redirect_to message_view_path(id: message.group.groupname, message_id:message.id)
        else
          flash[:error] = 'Something\'s not right.'
          redirect_to message_view_path(id: message.group.groupname, message_id:message.id)
        end
      else
        flash[:error] = 'Something\'s not right.'
        redirect_to group_path(id: message.group.groupname)
      end
    else
      flash[:error] = 'You need to sign up and select a valid message.'
      redirect_back fallback_location: '/'
    end
  end

  private

  def comment_params
    params.require(:comment).permit!
  end

end