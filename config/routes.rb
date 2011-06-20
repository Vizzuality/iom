Iom::Application.routes.draw do

  # Home
  root :to => "sites#home"
  match 'home2' => 'sites#home'
  match 'about' => 'sites#about'
  match 'about-interaction' => 'sites#about_interaction'
  match 'about-data' => 'sites#about_data'
  match 'link-ngo-aid-map' => 'sites#link_ngo_aid_map'
  match 'make-your-own-map' => 'sites#make_your_own_map'
  match 'faq' => 'sites#faq'
  match 'contact' => 'sites#contact'
  match 'explore' => 'sites#explore'

  # Session
  resource :session, :only => [:new, :create, :destroy]
  match 'login' => 'sessions#new', :as => :login
  match 'logout' => 'sessions#destroy', :as => :logout

  # Front urls
  resources :donors,        :only => [:index, :show]
  resources :projects,      :only => [:index, :show]
  resources :organizations, :only => [:index, :show]

  match 'regions/:id' => 'georegion#old_regions'
  # HACK!! route globbing doesn't work well when trying to get the request format in Rails <=3.0.7
  match 'location/*ids.csv' => 'georegion#show', :as => 'location', :format => 'csv'
  match 'location/*ids.xls' => 'georegion#show', :as => 'location', :format => 'xls'
  match 'location/*ids.kml' => 'georegion#show', :as => 'location', :format => 'kml'
  # End HACK!!
  match 'location/*ids' => 'georegion#show', :as => 'location'

  # clusters and sector work through the same controller and view
  match 'sectors/:id' => 'clusters_sectors#show', :as => 'sector'
  match 'clusters/:id'   => 'clusters_sectors#show', :as => 'cluster'

  # pages
  match '/p/:id' => 'pages#show', :as => :page
  # search
  match '/search' => 'search#index', :as => :search
  # list of regions of each level
  match '/geo/regions/1/:id/json' => 'georegion#list_regions1_from_country', :format => :json
  match '/geo/regions/2/:id/json' => 'georegion#list_regions2_from_country', :format => :json
  match '/geo/regions/3/:id/json' => 'georegion#list_regions3_from_country', :format => :json

  # Administration
  namespace :admin do
    match '/' => 'admin#index', :as => :admin
    match '/export_projects' => 'admin#export_projects', :as => :export_projects
    match '/export_organizations' => 'admin#export_organizations', :as => :export_organizations
    resources :settings, :only => [:edit, :update]
    resources :tags, :only => [:index]
    resources :regions, :only => [:index]
    resources :organizations do
      resources :projects, :only => [:index]
      resources :media_resources, :only => [:index, :create, :update, :destroy]
      resources :resources, :only => [:index, :create, :destroy, :update]
      get 'specific_information/:site_id', :on => :member, :action => 'specific_information', :as => 'organization_site_specific_information'
      put 'destroy_logo', :on => :member
    end
    resources :donors do
      resources :media_resources, :only => [:index, :create, :update, :destroy]
      resources :resources, :only => [:index, :create, :destroy]
      get 'projects', :on => :member
      get 'specific_information/:site_id', :on => :member, :action => 'specific_information', :as => 'donor_site_specific_information'
      put 'destroy_logo', :on => :member
    end
    resources :projects do
      resources :media_resources, :only => [:index, :create, :update, :destroy]
      resources :resources, :only => [:index, :create, :destroy, :update]
      get 'donations', :on => :member
      resources :donations, :only => [:create, :destroy]
    end
    resources :sites do
      get 'customization', :on => :member
      get 'projects', :on => :member
      post 'toggle_status', :on => :member
      put 'destroy_aid_map_image', :on => :member
      put 'destroy_logo', :on => :member
      resources :partners, :only => [:create, :destroy]
      resources :media_resources, :only => [:index, :create, :update, :destroy]
      resources :resources, :only => [:index, :create, :destroy, :update]
      resources :pages
    end
  end

end