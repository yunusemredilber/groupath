class UsersController < ApplicationController

  before_action :select_user, only: [:show, :edit, :update, :destroy, :followers]
  before_action :allowed?, only: [:edit, :create, :destroy]
  before_action :followed_users, only: [:show]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = 'Welcome!'
      redirect_to profile_path(@user)
    else
      render :new
    end
  end



  def update
    update_params = user_params
    if update_params.has_key?(:password)
      flash[:notice] = 'How dare you!'
      update_params.delete([:password,:password_confirmation])
    end
    if @user.update_columns(username: update_params[:username],
                    first_name: update_params[:first_name],
                    last_name: update_params[:last_name],
                    email: update_params[:email]
    )
      flash[:notice] = 'Profile Updated!'
      redirect_to profile_path(@user)
    else
      flash[:notice] = @user.errors.full_messages
      render :'users/edit'
    end
  end

  def destroy
    @user.destroy
    redirect_to '/'
  end

  def followers
    @current_users_followers = []
    current_user.followers.each do |follow|
      @current_users_followers.push(follow.follower_id)
    end
    @current_users_followers
  end

  def my_groups
  end

  private

  def user_params
    params.require(:user).permit!
  end

  def select_user
    @user = User.find_by_username(params[:id])
  end

  def allowed?
    user = select_user
    unless user == current_user
      redirect_to profile_path(user), alert: 'Nope.'
    end
  end

  def followed_users
    @followed_users = []
    @user.follows do |follow|
      @followed_users.push(User.find(follow.follwed_id))
    end
  end
end
