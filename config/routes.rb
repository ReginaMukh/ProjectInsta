Rails.application.routes.draw do
  devise_for :users
  resources :posts, only: [:create, :destroy]
  resources :relationships, only: [:create, :destroy]
 root "root#home"
 
  resources :users do
    member do
      get :following, :followers
    end
  end

end

  