Rails.application.routes.draw do
  resources :books
  get 'users/nicolas1'
  get 'users/home'
  post 'users/home'
  post 'users/create'
  post '/login', to: 'users#login'
  resources :users
  #resources :users, only: [:create]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root "users#index"
end
