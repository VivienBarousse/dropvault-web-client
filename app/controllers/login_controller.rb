require 'uri'
require 'net/dav'

class LoginController < ApplicationController

  def init
    if (check_credentials(session[:username], session[:password]))
      redirect_to view_path
    end
  end

  def login
    if check_credentials(params[:username], params[:password])
      session[:username] = params[:username]
      session[:password] = params[:password]
      redirect_to view_path
    else
      redirect_to :back
    end
  end

  def check_credentials(username, password)
    if (username.nil? || password.nil?)
      return false
    end
    uri = URI.parse(webdav_endpoint)
    uri = uri.merge(username)
    dav = Net::DAV.new(uri.to_s)
    dav.credentials(username, password)
    dav.exists?(uri.path)
  end

end
