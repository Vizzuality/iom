class Sites::SitesController < ApplicationController

  def home
    if logged_in?
      redirect_to admin_admin_path
    else
      redirect_to login_path
    end
  end

end
