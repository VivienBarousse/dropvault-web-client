DropvaultWebClient::Application.routes.draw do

  root :to => 'login#init', :as => :login_init

  match 'view/' => 'view#get', :defaults => {:path => '.'}, :as => :view

  match 'view/:path' => 'view#get', :constraints => {:path => /.*/}

  match 'login/login' => 'login#login', :via => :post, :as => :login

end
