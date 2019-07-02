class SearchController < ApplicationController
  def index
    search_params
    if params[:search]
      @query = params[:search]
      find_data
    end
  end

  private

  def search_params
    #params[:search].permit
  end

  def find_data

    first_message = Message.first
    first_comment = Comment.first
    first_user = User.first
    first_group = Group.first

    @data = []
    users = User.where('username LIKE ?', "%#{params[:search]}%")
    users.each do |user|
      data = {type: '', user: first_user, created_at: ''}
      data[:user] = user
      data[:type] = 'user'
      data[:created_at] = user.created_at
      @data.push(data)
    end

    messages = Message.where('text LIKE ?', "%#{params[:search]}%")
    messages.each do |message|
      data = {type: '', message: first_message, created_at: ''}
      data[:message] = message
      data[:type] = 'message'
      data[:created_at] = message.created_at
      @data.push(data) unless message.user == current_user
    end

    comments = Comment.where('text LIKE ?', "%#{params[:search]}%")
    comments.each do |comment|
      data = {type: '', comment: first_comment, created_at: ''}
      data[:comment] = comment
      data[:type] = 'comment'
      data[:created_at] = comment.created_at
      @data.push(data) unless comment.user == current_user
    end

    groups = Group.where('groupname LIKE ? OR title LIKE ? OR description LIKE ?', "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%")
    groups.each do |group|
      data = {type: '', group: first_group, created_at: ''}
      data[:group] = group
      data[:type] = 'group'
      data[:created_at] = group.created_at
      @data.push(data)
    end

    @data = @data.sort_by{ |data| data[:created_at] }
    @data.reverse!
  end

end
