Rails.application.routes.draw do
  root 'home#index'
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    passwords: 'users/passwords',
  }
  devise_scope :user do
    get "sign_in", :to => "users/sessions#new"
    get "sign_out", :to => "users/sessions#destroy"
  end
  resources :users, only: [:show, :destroy] do
    member do
      get :following, :followers
    end
  end
  resources :posts do
    resources :comments, only: [:create, :destroy]
  end
  resources :relationships, only: [:create, :destroy]
end
