require 'rspotify/oauth'

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :spotify, ENV["SPOTIFY_CLIENT_ID"], ENV["SPOTIFY_SECRET"], scope: 'user-read-email user-read-private user-library-read playlist-modify-public playlist-modify-private streaming ugc-image-upload'
end

OmniAuth.config.allowed_request_methods = [:post, :get]
