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

end
