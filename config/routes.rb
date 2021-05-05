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
    patch "mark/:id", to: "items#mark", as: "item_mark"
    patch "uncheck/:id", to: "items#uncheck", as: "item_uncheck"
  end
  resources :memberships
end
