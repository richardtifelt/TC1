class AuthController < ApplicationController
  def redirect
    session['twitter_credentials'] = request.env["omniauth.auth"]["credentials"]
    redirect_to root_path
  end
  
  def failed
    flash[:warning] = "Something went wrong! Please try again!"
    redirect_to root_path
  end
end