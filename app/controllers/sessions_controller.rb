class SessionsController < ApplicationController

  # Create session
  def create
    params.require(:session).permit!
    user = User.find_by_username(params[:session][:username])
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      redirect_to home_path, notice: 'Welcome!'
    else
      flash[:error] = 'That didn\'t work out.'
      redirect_to :signin
    end
  end

  # Delete session
  def destroy
    session[:user_id] = nil
    redirect_to signin_path, notice: 'Goodbye!'
  end
end
