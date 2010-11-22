Iom::Application.routes.draw do

  # Home
  root :to => "sites#home"

  # Session
  resource :session, :only => [:new, :create, :destroy]
  match 'login' => 'sessions#new', :as => :login
  match 'logout' => 'sessions#destroy', :as => :logout

  # Administration
  namespace :admin do
    match '/' => 'admin#index', :as => :admin
    resources :tags, :only => [:index]
    resources :organizations do
      resources :projects, :only => [:index]
      resources :media_resources, :only => [:index, :create, :destroy]
      resources :resources, :only => [:index, :create, :destroy]
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
    end
  end

end
