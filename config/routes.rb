Rails.application.routes.draw do
  # Auth routes
  devise_for :users, controllers: { registrations: 'users/registrations'}, path: '', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    sign_up: 'register',
    account_update: 'users/:id/update',
  }
  as :user do
    get 'login', to: 'devise/sessions#new', as: :login
    delete 'logout', to: 'devise/sessions#destroy', as: :logout
    get 'register', to: 'devise/registrations#new', as: :register
    get 'users/:id/update', to: 'devise/registrations#edit', as: :edit_user
  end
  # end of Auth routes


  resources :users, only: [:show]



  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "posts#index"
end
