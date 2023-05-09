Rails.application.routes.draw do
  root 'static_pages#home'
  post 'sign_up', to: 'users#create'
  get 'sign_up', to: 'users#new'
  resources :confirmations, only: [:create, :edit, :new], param: :confirmation_token
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"
  get "login", to: "sessions#new"
  resources :passwords, only: [:create, :edit, :new, :update], param: :password_reset_token
  put "account", to: "users#update"
  get "account", to: "users#edit"
  delete "account", to: "users#destroy"
  get "dashboard", to: "dashboard#show"
  resources :to_do_list_invites, except: [:edit, :update] do
    post "accept", to: "to_do_list_invites#accept"
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
