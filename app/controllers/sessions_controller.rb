class SessionsController < ApplicationController
  def new
  end

  def create
    params.require(:session).permit!
    user = User.find_by_username(params[:session][:username])
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      redirect_to profile_path(user), notice: 'Welcome!'
    else
      flash[:error] = 'That didn\'t work out.'
      redirect_to :signin
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to signin_path, notice: 'Goodbye!'
  end
end
