Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get '/auth/spotify/callback', to: 'users#spotify'

  # Defines the root path route ("/")
  root to: "pages#home"
  resources :events, only: %i[new create]
end
