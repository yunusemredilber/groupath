class WelcomeController < ApplicationController

  # Welcome page
  def index
    if signed_in?
      timeline
    else
      redirect_to signin_path
    end
  end

  private

  def timeline

    first_message = Message.first
    first_comment = Comment.first
    first_follow = Follow.first
    first_membership = Membership.first

    @data = []
    current_user.groups.each do |group|
      group.messages.each do |message|
        data = {type: '', message: first_message, created_at: ''}
        data[:type] = 'message'
        data[:message] = message
        data[:created_at] = message.created_at
        @data.push(data) unless message.user == current_user

        message.comments.each do |comment|
          data = {type: '', comment: first_comment, created_at: ''}
          data[:type] = 'comment'
          data[:comment] = comment
          data[:created_at] = comment.created_at
          @data.push(data) unless comment.user == current_user
        end
      end
    end

    Follow.where('followed_id  = ?', current_user.id).each do |follow|
      data = {type: 'follow', follow: first_follow, created_at: ''}
      data[:type] = 'follow'
      data[:follow] = follow
      data[:created_at] = follow.created_at
      @data.push(data)
    end

    Membership.where('user_id  = ? AND active = ?', current_user.id, true).each do |membership|
      data = {type: 'membership', membership: first_membership, created_at: ''}
      data[:type] = 'membership'
      data[:membership] = membership
      data[:created_at] = membership.updated_at
      @data.push(data)
    end

    @data = @data.sort_by{ |data| data[:created_at] }
    @data.reverse!
  end
end
