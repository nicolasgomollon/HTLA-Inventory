HTLAInventory::Application.routes.draw do

  get "home/index"

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
  namespace :admin do
    resources :students do
      collection do
        get :import
        post :upload
      end
    end
    resources :ownerships, :as => :computer_ownerships
    resources :computers do
      collection do
        get :import
        post :upload
        match "reports/bad" => "reports#bad"
        match "reports/good" => "reports#good"
        match "reports/parts" => "reports#parts"
        match "reports/assigned" => "reports#assigned"
        match "reports/checkout" => "reports#checkout"
        match "reports/partsview" => "reports#partsview"
        match "reports/all" => "reports#fullcsv"
        match "reports" => "reports#index"
      end
    end
    resources :locations
    resources :templates, :as => :computer_templates
    resources :repairs, :as => :repair_orders
    resources :bills
    resources :users, :as => :admin_users
    get "login" => "sessions#new" 
    post "login" => "sessions#create"
    get "logout" => "sessions#destroy"
    root :to => "admin#index"
  end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => 'home#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
