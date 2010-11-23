Iom::Application.routes.draw do

  # Home
  root :to => "sites_dashboard#home"

  # Session
  resource :session, :only => [:new, :create, :destroy]
  match 'login' => 'sessions#new', :as => :login
  match 'logout' => 'sessions#destroy', :as => :logout

  # Front
  namespace :sites do
    resources :organizations
  end
  
  # Administration
  namespace :admin do
    match '/' => 'admin#index', :as => :admin
    resources :tags, :only => [:index]
    resources :organizations do
      resources :projects, :only => [:index]
      resources :media_resources, :only => [:index, :create, :destroy]
      resources :resources, :only => [:index, :create, :destroy]
      get 'specific_information/:site_id', :on => :member, :action => 'specific_information', :as => 'organization_site_specific_information'
    end
    resources :donors do
      resources :media_resources, :only => [:index, :create, :destroy]
      resources :resources, :only => [:index, :create, :destroy]
      get 'projects', :on => :member
    end
    resources :projects do
      resources :media_resources, :only => [:index, :create, :destroy]
      resources :resources, :only => [:index, :create, :destroy]
      get 'donations', :on => :member
      resources :donations, :only => [:create, :destroy]
    end
    resources :sites do
      get 'customization', :on => :member
      get 'projects', :on => :member
      resources :partners, :only => [:create, :destroy]
      resources :media_resources, :only => [:index, :create, :destroy]
      resources :resources, :only => [:index, :create, :destroy]
      resources :pages
    end
  end

end
