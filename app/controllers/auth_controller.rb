class AuthController < ApplicationController
  def redirect
    session[:credentials] = request.env["omniauth.auth"]["credentials"]
    
    Rails.logger.info("-------------------- #{auth.inspect}")
    session[:twitter_user] = 123
    redirect_to root_path
  end
  
  def failed
    flash[:warning] = "Something went wrong! Please try again!"
    redirect_to root_path
  end
end