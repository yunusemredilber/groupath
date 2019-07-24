class CommentsController < ApplicationController

  # Create a new comment
  def create
    comment = Comment.new
    comment[:text] = comment_params[:text]
    message = Message.find(comment_params[:message])
    if signed_in? && message
      if message.group.users.include?(current_user) || message.group.admin_id == current_user.id
        comment.user = current_user
        comment.message = message
        if comment.save
          ActionCable.server.broadcast("notifications_#{message.user.channel}",
                                       html: html(comment)
          )
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

  # Delete a comment
  def destroy
    comment = Comment.find(params[:id])
    if comment && signed_in? && comment.user == current_user
      if comment.destroy
        flash[:success] = 'Comment deleted!'
      else
        flash[:error] = 'Something wrong!'
      end
    else
      flash[:error] = 'I think you are doing something wrong!'
    end
    redirect_back fallback_location: '/'
  end

  private

  def comment_params
    params.require(:comment).permit(:text, :message)
  end

  def html(comment)
    ApplicationController.render(partial: 'welcome/comment', locals: { comment: comment, date: comment.created_at })
  end

end
