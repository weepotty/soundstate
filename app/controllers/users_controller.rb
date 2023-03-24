require 'csv'

class UsersController < ApplicationController
  def spotify
    # create an RSpotify User
    spotify_user = RSpotify::User.new(request.env['omniauth.auth'])
    spotify_auth = spotify_user.to_hash
    @user = User.create_from_spotify(spotify_user, spotify_auth)

    if @user.persisted?
      flash[:notice] = I18n.t 'devise.omniauth_callbacks.success', kind: 'Spotify'
      sign_in_and_redirect @user, event: :authentication
    else
      # Removing extra as it can overflow some session stores
      session['devise.spotify_data'] = request.env['omniauth.auth'].except('extra')
      redirect_to new_user_registration_url, alert: @user.errors.full_messages.join("\n")
    end

    # get all the songs from user's library and their properties, and load into songs table
    ::ImportSongsService.call(
      spotify_user: spotify_user,
      current_user: current_user
    )
  end

  # GET /users/
  def index
    if params[:query]
      @query = params[:query]
      @users = User.search_by_nickname(@query)
    else
      @users = User.all
    end
  end

  # GET /users/:id
  def show
    current_user
    @playlists = current_user.playlists
    @events = current_user.events
  end
end
