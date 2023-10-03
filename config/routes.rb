Rails.application.routes.draw do
  
  devise_for :users
  resources :posts
  resources :comments
  resources :relationships, only: [:create, :destroy]
 resources :likes, only: [:create, :destroy]
  root "root#home"
 
  resources :users do
    member do
      get :following, :followers
    end
  end

  resources :posts do
    resources :comments
    resources :likes
  end

end

  