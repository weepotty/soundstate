Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get '/auth/spotify/callback', to: 'users#spotify'

  # Defines the root path route ("/")
  root to: "pages#home"

  resources :users, only: %i[index show] do
    resources :playlists, only: %i[index]
  end

  resources :events, only: %i[index new create edit update] do
    resources :playlists, only: %i[new create]
  end

  resources :playlists, only: %i[show]
end
