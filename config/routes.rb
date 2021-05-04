Rails.application.routes.draw do
  root "users#index"
  devise_for :users, controllers: { registrations: "users/registrations",
    sessions: "users/sessions",
    confirmations: "users/confirmations",
    passwords: "users/passwords",
    invitations: 'users/invitations' }
  
  get 'checkout', to: 'checkouts#show'
  get 'billing', to: 'billing#show'

  resources :invites
  resources :users
  resources :accounts
  resources :boxes
  resources :memberships
end
