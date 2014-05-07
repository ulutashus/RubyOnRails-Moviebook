Moviebook::Application.routes.draw do
  root to: "index#index"

  resources :users
  resources :movies
  resources :posts
  resources :search, only: [:index]
  resources :sessions, only: [:new, :create, :destroy]
  resources :microposts, only: [:create, :destroy]
  resources :relationships, only: [:create, :destroy]

  scope ":username", :as => "users" do
    resources :users
  end
  
  # user routes
  match '/signup',  to: 'users#new'
  match '/follow',  to: 'users#follow'  
  match '/unfollow',  to: 'users#unfollow'
  # session routes
  match '/signin',  to: 'sessions#new'
  match '/signout', to: 'sessions#destroy'
  # movie routes
  match '/add_list', to: 'movies#add_list'
  # app routes
  match '/app_post', to: 'application#app_post', via: 'post'
  match '/app_signup', to: 'application#app_signup', via: 'post'
  match '/app_signin', to: 'application#app_signin', via: 'post'
  match '/app_addwatch', to: 'application#app_addwatch', via: 'post'
  match '/app_sync', to: 'application#app_sync', via: 'post'
end
