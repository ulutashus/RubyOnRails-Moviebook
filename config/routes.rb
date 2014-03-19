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
  match '/signin',  to: 'sessions#new'
  match '/signout', to: 'sessions#destroy'
  match '/users/app_signup', to: 'users#app_signup', via: 'post'
  match '/users/app_signin', to: 'users#app_signin', via: 'post'
  match '/posts/app_post', to: 'posts#app_post', via: 'post'
end
