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
  
  match '/signup',  to: 'users#new'
  match '/app_signup', to: 'users#app_new', via: 'post'
  match '/follow',  to: 'users#follow'  
  match '/unfollow',  to: 'users#unfollow'

  match '/signin',  to: 'sessions#new'
  match '/app_signin', to: 'sessions#app_new', via: 'post'
  match '/signout', to: 'sessions#destroy'
  
  match '/app_post', to: 'posts#app_post', via: 'post'
end
