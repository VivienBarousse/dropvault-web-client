require 'dropdav/dropdav'

class ApplicationController < ActionController::Base

  protect_from_forgery

  def conf
    if @conf.nil?
      cpath = "#{Rails.root}/config/dropvault.yml"
      conf = YAML.load_file(cpath) rescue {}
      @conf = conf['common']
    end
    @conf
  end

  def webdav_endpoint
    conf['webdav_endpoint']
  end

  def dav_item(path)
    dav = DropDAV::DropDAV.new(webdav_endpoint + session[:username] + "/")
    dav.credentials(session[:username], session[:password])
    dav.item(path)
  end

end
