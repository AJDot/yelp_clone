class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in?
  helper_method :date_from

  def current_user
    @current_user = User.find session[:user_id] if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  def require_user
    return if logged_in?

    flash[:danger] = 'You must be logged in to do that.'
    redirect_to login_path
  end

  def date_from(datetime)
    datetime.strftime('%b %e, %Y')
  end
end
