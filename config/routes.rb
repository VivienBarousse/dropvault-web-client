DropvaultWebClient::Application.routes.draw do

  get "search/search"

  root :to => 'login#init', :as => :login_init

  match 'view/' => 'view#get', :defaults => {:path => '.'}, :as => :view

  match 'view/:path' => 'view#get', :constraints => {:path => /.*/}, :as => :view

  match 'login/login' => 'login#login', :via => :post, :as => :login

  match 'logout/logout' => 'logout#logout', :as => :logout

end
