Rails.application.routes.draw do
  get 'playlists/index'
  get 'playlists/show'
  get 'playlists/create'
  get 'playlists/edit'
  get 'playlists/update'
  get 'playlists/delete'
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html


  get '/auth/spotify/callback', to: 'users#spotify'


  # Defines the root path route ("/")
  root to: "pages#home"
end
