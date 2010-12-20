Iom::Application.routes.draw do

  # Home
  root :to => "sites#home"

  # Session
  resource :session, :only => [:new, :create, :destroy]
  match 'login' => 'sessions#new', :as => :login
  match 'logout' => 'sessions#destroy', :as => :logout

  # Front urls
  resources :regions,       :only => [:show]
  resources :countries,     :only => [:show]
  resources :sectors,       :only => [:show]
  resources :clusters,      :only => [:show]
  resources :donors,        :only => [:index, :show]
  resources :projects,      :only => [:index, :show]
  resources :organizations, :only => [:index, :show]
  # pages
  match '/p/:id' => 'pages#show', :as => :page
  # search
  match '/search' => 'search#index', :as => :search

  # Dashboard
  match '/dashboard' => 'dashboard#index', :as => :dashboard
  
  # API
  namespace :api do
    get "countries" => "geodata#countries"
    get "regions" => "geodata#regions"
  end

  # Administration
  namespace :admin do
    match '/' => 'admin#index', :as => :admin
    resources :settings, :only => [:edit, :update]
    resources :tags, :only => [:index]
    resources :regions, :only => [:index]
    resources :organizations do
      resources :projects, :only => [:index]
      resources :media_resources, :only => [:index, :create, :update, :destroy]
      resources :resources, :only => [:index, :create, :destroy, :update]
      get 'specific_information/:site_id', :on => :member, :action => 'specific_information', :as => 'organization_site_specific_information'
    end
    resources :donors do
      resources :media_resources, :only => [:index, :create, :update, :destroy]
      resources :resources, :only => [:index, :create, :destroy]
      get 'projects', :on => :member
      get 'specific_information/:site_id', :on => :member, :action => 'specific_information', :as => 'donor_site_specific_information'
    end
    resources :projects do
      resources :media_resources, :only => [:index, :create, :destroy]
      resources :resources, :only => [:index, :create, :destroy, :update]
      get 'donations', :on => :member
      resources :donations, :only => [:create, :destroy]
    end
    resources :sites do
      get 'customization', :on => :member
      get 'projects', :on => :member
      post 'toggle_status', :on => :member
      resources :partners, :only => [:create, :destroy]
      resources :media_resources, :only => [:index, :create, :update, :destroy]
      resources :resources, :only => [:index, :create, :destroy, :update]
      resources :pages
    end
  end

end