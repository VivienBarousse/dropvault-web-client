require 'uri'
require 'net/dav'

class LoginController < ApplicationController

  def init
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
    uri = URI.parse("http://thom.aperigeek.com:8080/dropvault/rs/dav/")
    uri = uri.merge(username)
    dav = Net::DAV.new(uri.to_s)
    dav.credentials(username, password)
    dav.exists?(uri.path)
  end

end
