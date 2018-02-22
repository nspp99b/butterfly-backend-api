Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users, only: [:index, :show]
  resources :flaps, only: [:index, :create, :show, :destroy]
  resources :relationships, only: [:create]

  post "/login", to: 'auth#login'
  post '/logout', to: 'auth#logout'
  get '/current_user', to: 'auth#currentUser'
  post '/signup', to: 'auth#signup'

end
