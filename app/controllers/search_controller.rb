require 'uri'
require 'dropdav/dropdav'

class SearchController < ApplicationController

  def search
    searchUrl = "http://dav.dropvault.aperigeek.com/rs/query/"
    uri = URI.parse(searchUrl)
    uri = uri.merge(session[:username] + "/")
    uri = uri.merge(params[:query])
    res = Net::HTTP.start(uri.host, uri.port) do |http|
      http.get(uri.path + "?password=" + session[:password])
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
