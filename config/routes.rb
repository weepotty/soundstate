Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html


  get '/auth/spotify/callback', to: 'pages#home'
  # Defines the root path route ("/")
  root to: "pages#home"
end
