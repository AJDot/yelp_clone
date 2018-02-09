class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "Welcome, #{user.first_name}."
      redirect_to root_path
    else
      flash[:danger] = 'There was something wrong with your email or password.'
      redirect_to login_path
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = 'You have logged out. Goodbye!'
    redirect_to root_path
  end
end
