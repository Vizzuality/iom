class PasswordsController < ApplicationController

  def new

  end

  def create
    user = User.find_by_email(params[:email])

    if user.present?
      user.send_password_reset
    else
      render :new
    end
  end

  def edit
    @user = User.find_by_password_reset_token(params[:id])
  end

  def update
    @user = User.find_by_password_reset_token(params[:id])

    if @user.password_reset_sent_at < 2.hours.ago
      redirect_to new_password_reset_path, :alert => "Password reset has expired."
    elsif @user.update_password(params[:password], params[:password_confirmation])
      if @user.not_blocked?
        self.current_user = @user
        new_cookie_flag = (params[:remember_me] == "1")
        handle_remember_cookie! new_cookie_flag
        redirect_back_or_default(admin_admin_path, :notice => "Password has been reset!")
      else
        redirect_to root_url, :notice => "Password has been reset!"
      end
    else
      render :edit
    end
  end

end
