require 'uri'
require 'dropdav/dropdav'

class SearchController < ApplicationController

  before_filter :ensure_login

  def search
    uri = URI.parse(search_endpoint)

    req = Net::HTTP::Get.new(uri.path + "?q=" + CGI::escape(params[:query]))
    req.basic_auth session[:username], session[:password]

    res = Net::HTTP.start(uri.host, uri.port) do |http|
      http.request(req)
    end

    res = JSON.parse res.body
    @results = []
    res.each do |result|
        item = dav_item("./" + result)
        def item.path 
          @path
        end
        def item.path=(p)
          @path = p
        end
        item.path = result
        @results << item
    end
  end

end
