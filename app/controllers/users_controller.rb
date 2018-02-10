class UsersController < ApplicationController
  def show
    @user = User.find params[:id]
    @reviews = @user.reviews.limit(Review::PER_PAGE).offset(params[:offset])
    @reviews_pages = Review.page_count_by_user @user
  end

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
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end
end
