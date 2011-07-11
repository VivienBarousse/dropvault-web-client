require 'uri'
require 'net/dav'

class LoginController < ApplicationController

  def init
  end

  def login
    uri = URI.parse("http://thom.aperigeek.com:8080/dropvault/rs/dav/")
    uri = uri.merge(params[:username])
    dav = Net::DAV.new(uri.to_s)
    dav.credentials(params[:username], params[:password])
    result = dav.propfind(uri.path) rescue nil
    if result.nil?
      redirect_to :back
    else
      session[:username] = params[:username]
      session[:password] = params[:password]
      redirect_to view_path
    end
  end

end
