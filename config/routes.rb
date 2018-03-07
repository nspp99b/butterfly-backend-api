Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      resources :users, only: [:index, :show, :update] do
        member do
          get :following, :followers
        end
      end
      resources :flaps, only: [:index, :create, :show, :update]
      resources :relationships, only: [:index, :create]
      resources :connections, only: [:create, :index]
      post '/unfollow', to: 'connections#unfollow'
    end
  end

  post '/login', to: 'auth#login'
  get '/current_user', to: 'auth#currentUser'
  post '/signup', to: 'auth#signup'
end
