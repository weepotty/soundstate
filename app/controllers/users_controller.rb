require 'csv'

class UsersController < ApplicationController
  def spotify
    # create an RSpotify User
    spotify_user = RSpotify::User.new(request.env['omniauth.auth'])
    @user = User.create_user(spotify_user)
    if @user.persisted?
      flash[:notice] = I18n.t 'devise.omniauth_callbacks.success', kind: 'Spotify'
      sign_in_and_redirect @user, event: :authentication
    else
      # Removing extra as it can overflow some session stores
      session['devise.spotify_data'] = request.env['omniauth.auth'].except('extra')
      redirect_to new_user_registration_url, alert: @user.errors.full_messages.join("\n")
    end

    # get all the from user's library
    @tracks = spotify_user.saved_tracks(offset: 0, limit: 50)
    tracks_array = @tracks
    offset = 50
    while @tracks.count == 50
      @tracks = spotify_user.saved_tracks(offset:, limit: 50)
      tracks_array.concat(@tracks)
      offset += 50
    end




    # get the spotify song URIs from the filtered_array and create a playlist with these +/- store in user's spotify
    # play the playlist

  end

end
