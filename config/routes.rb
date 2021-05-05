Rails.application.routes.draw do
  root "users#index"
  devise_for :users, controllers: { registrations: "users/registrations",
    sessions: "users/sessions",
    confirmations: "users/confirmations",
    passwords: "users/passwords",
    invitations: 'users/invitations' }

  resources :users
  resources :accounts
  resources :boxes do
    resources :items
  end
  resources :memberships
end
