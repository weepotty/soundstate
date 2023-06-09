Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get '/auth/spotify/callback', to: 'users#spotify'

  # Defines the root path route ("/")
  root to: "pages#home"

  # Routes to render the Loading Songs loading page.
  get '/load_songs_page', to: 'pages#load_songs_page'
  get '/load_songs', to: 'pages#load_songs'

  resources :users, only: %i[index show edit update] do
    resources :playlists, only: %i[index]
  end

  resources :events, only: %i[index new create edit update destroy] do
    get :image
    resources :playlists, only: %i[new create]
  end

  resources :playlists, only: %i[show destroy] do
    collection do
      post :toggle_shared
    end
  end
end
