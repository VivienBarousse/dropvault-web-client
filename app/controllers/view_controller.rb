require 'uri'
require 'net/dav'

class ViewController < ApplicationController

  before_filter :ensure_login

  def get
      baseUri = URI.parse(webdav_endpoint)
      baseUri = baseUri.merge(session[:username] + "/")
      path = params[:path]
      dav = Net::DAV.new(baseUri.to_s)
      dav.credentials(session[:username],session[:password])

      currentUri = baseUri.merge(path + "/")
      currentType = :directory
      if (path != '.')
        parent = currentUri.merge("..").to_s
        dav.find(parent) do |item|
          if (item.uri.to_s == currentUri.to_s || item.uri.to_s + "/" == currentUri.to_s)
            currentType = item.type
          end
        end
      end

      @items = []
      dav.find(path) do |item|
        @items << item
      end
      if (currentType == :file)
        self.content_type = @items[0].properties.contenttype
        self.response_body = dav.get(path)
      end
  end

end
