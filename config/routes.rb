Rails.application.routes.draw do
  # Auth routes
  devise_for :users,
             controllers: {
               registrations: 'users/registrations',
               passwords: 'users/passwords'
             },
             path: '',
             path_names: {
                sign_in: 'login',
                sign_out: 'logout',
                sign_up: 'register',
                account_update: 'users/:id/update',
              }
  # end of Auth routes
  get 'login', to: 'devise/sessions#new', as: :login
  delete 'logout', to: 'devise/sessions#destroy', as: :logout
  get 'register', to: 'devise/registrations#new', as: :register
  get 'users/:username/update', to: 'devise/registrations#edit', as: :edit_user
  get 'users/:username/change-password', to: 'users#change_password', as: :change_password



  resources :users, only: [:show], path: 'users', param: :username do
    member do
      get 'posts', to: 'users#posts', as: :posts
      get 'requests', to: 'users#requests', as: :requests
    end
  end

  resources :requests, only: [:create] do
    member do
      post 'accept', to: 'requests#accept', as: :accept
      post 'reject', to: 'requests#reject', as: :reject
    end
  end




  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  resources :posts
  root "posts#index"
end
