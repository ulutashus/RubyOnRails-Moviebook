Moviebook::Application.routes.draw do
#  resources :users do
#    member do
#      get :following, :followers
#    end
#  end
  scope ":username", :as => "users" do
    resources :users
  end
  resources :users
  resources :sessions, only: [:new, :create, :destroy]
  resources :microposts, only: [:create, :destroy]
  resources :relationships, only: [:create, :destroy]

  root to: "index#index"

  match '/signup',  to: 'users#new'
  match '/app_signup', to: 'users#app_new', via: 'post'
  match '/follow',  to: 'users#follow'  
  match '/unfollow',  to: 'users#unfollow'

  match '/signin',  to: 'sessions#new'
  match '/app_signin', to: 'sessions#app_new', via: 'post'
  match '/signout', to: 'sessions#destroy'
  
  match '/posts/app_post', to: 'posts#app_post', via: 'post'
end
