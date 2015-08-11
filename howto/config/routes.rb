Howto::Application.routes.draw do
  resources :clubs

  resources :classements

  resources :mon_equipes
  
  resources :transferts
  
  resources :entrainemets

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
  resources :contrats

  resources :staffs

  resources :saisons

  resources :divisions do
    resource :list
  end

  resources :historiques

  resources :equipes 
	
  resources :joueurs

  resources :user_sessions

  resources :users

 resources :mon_equipe 
 
 resources :stats
 
  match "login", :controller => "user_sessions", :action => "new", :via => [:post]
  match "logout", :controller => "user_sessions", :action => "destroy", :via => [:get, :post]
  match "test" , :controller => "equipes", :action => "test", :via => [:get, :post]
  match "update_transfert", :controller => "transferts", :action =>"update_transfert", :via => [:get, :post]
   #login "login", :controller => "user_sessions", :action => "new"
   #ogout "logout", :controller => "user_sessions", :action => "destroy"
 #  resources :users, :posts, :user_sessions
 # match 'login' => "user_sessions#new",      :as => :login
 # match 'logout' => "user_sessions#destroy", :as => :logout

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

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

	#root :controller => :users, :action => :index
	root :controller => :mon_equipe, :action => :index
  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  match ':controller(/:action(/:id))(.:format)', :via => [:get, :post]
end
