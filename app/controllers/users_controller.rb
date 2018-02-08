class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = "You are registered! Welcome, #{@user.first_name}!"
      session[:user_id] = @user.id
      redirect_to businesses_path
    else
      render :new, as: 'register'
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end
end
