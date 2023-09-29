Rails.application.routes.draw do
  resources :comments
  devise_for :users
  resources :posts
  resources :relationships, only: [:create, :destroy]
 
  root "root#home"
 
  resources :users do
    member do
      get :following, :followers
    end
  end

  resources :posts do
    resources :comments
  end

end

  