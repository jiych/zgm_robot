ZgmRobot::Application.routes.draw do
  namespace :admin do
    get '/' => 'robots#index'
    get '/robots/index'
    get '/robots/delete/:id' => 'robots#delete'
    get '/robots/:id/edit' => 'robots#edit'
    get '/robots/learn'
    post '/robots/learn_aiml' => 'robots#learn_aiml'
    post '/robots/learn_words' => 'robots#learn_words'
    get '/robots/refresh' => 'robots#refresh'
    get '/robots/clear' => 'robots#clear'
    get '/robots/wikis' => 'robots#wikis'
    get '/robots/redis' => 'robots#redis'
    post '/robots/update_redis' => 'robots#update_redis'
    get '/robots/delete_wiki/:id' => 'robots#delete_wiki'
    get '/robots/clear_wikis' => 'robots#clear_wikis'
    get '/robots/clear_redis' => 'robots#clear_redis'
    get '/robots/logs' => 'robots#logs'
    resources :wikis
    resources :robots
  end
  get "/admin/login"
  post "/admin/login" => 'admin#authenticate'
  get "/admin/logout"
  get '/admin/setting'
  post '/admin/change_password'

  match '/robots/index' => 'robots#index'
  match '/robots/chat' => 'robots#chat'

  mount ExceptionLogger::Engine => "/exception_logger"

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

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => 'robots#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
