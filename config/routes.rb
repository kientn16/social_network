Rails.application.routes.draw do
  get 'site/index', as: :index

  root to: "site#index"
  # login authenticate
  get '/login' => 'sessions#new', as: :login
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'

  # users
  resources :users

  # add friend ajax
  post '/site/add_friend' => 'site#add_friend', as: :post_add_friend
  # un request ajax
  post '/site/un_request' => 'site#un_request', as: :post_un_request
  # un friend ajax
  post '/site/un_friend' => 'site#un_friend', as: :post_un_friend
  # add favorite ajax
  post '/site/add_favorite' => 'site#add_favorite', as: :post_add_favorite
  # un favorite ajax
  post '/site/un_favorite' => 'site#un_favorite', as: :post_un_favorite
  # accept friend
  post '/site/accept_friend' => 'site#accept_friend', as: :post_accept_friend
  # deny request friend
  post '/site/deny_request' => 'site#deny_request', as: :post_deny_request
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
end
