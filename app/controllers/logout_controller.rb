class LogoutController < ApplicationController

  def logout
    session[:username] = nil
    session[:password] = nil
    redirect_to :back
  end

end
