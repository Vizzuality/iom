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
    require 'ruby-debug'; debugger
    @user = User.find_by_password_reset_token(params[:id])

    if @user.password_reset_sent_at < 2.hours.ago
      redirect_to new_password_reset_path, :alert => "Password reset has expired."
    elsif @user.update_password(params[:user][:password], params[:user][:password_confirmation])
      redirect_to root_url, :notice => "Password has been reset!"
    else
      render :edit
    end
  end

end
