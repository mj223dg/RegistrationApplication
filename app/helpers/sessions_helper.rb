module SessionsHelper
  def log_in(user)
    session[:user_id] = user.id
  end


  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  def currentdev_user
    if (user_id = session[:user_id])
    @currentdev_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(cookies[:remember_token])
        log_in user
        @currentdev_user
      end
    end
  end

  def check_if_correct_user

   redirect_to root_path unless @user == currentdev_user
  end

  def logged_in?
    !currentdev_user.nil?
  end

  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  def log_out
    forget(currentdev_user)
    session.delete(:user_id)
    @currentdev_user = nil
  end

  def admin?
    currentdev_user.admin?
  end

  def check_if_admin
    unless logged_in?
      redirect_to login_path
    else
      unless currentdev_user.admin?
        redirect_to currentdev_user
      end
    end
  end
end
