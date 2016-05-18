Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  scope :page do
    get '/dataset', to: 'pages#dataset'
    get '/convert', to: 'pages#convert'
    get '/projection', to: 'pages#projection'
  end

  scope :api, defaults: { :format => 'json' } do
    get '/index', to: 'api/water_qualities#index'
    # get '/get_all', to: 'api/water_qualities#get_all'
    # get '/get_areas', to: 'api/water_qualities#get_areas'
    # get '/get_regions/:area_name', to: 'api/water_qualities#get_regions'
    get '/get_current_version', to: 'api/water_qualities#get_current_version'
    get '/get_daily_levels', to: 'api/water_qualities#get_daily_levels'
    # get '/get_closest_stage', to: 'api/water_qualities#get_closest_stage'
    get '/get_closest_catchment/:pcode', to: 'api/water_qualities#get_closest_catchment'
  end
end
