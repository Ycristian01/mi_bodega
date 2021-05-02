Rails.application.routes.draw do
  root "users#index"
  devise_for :users
  resources :invites
  resources :users
  resources :accounts
  resources :boxes
end
