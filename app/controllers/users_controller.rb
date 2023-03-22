require 'csv'

class UsersController < ApplicationController
  def spotify
    # create an RSpotify User
    spotify_user = RSpotify::User.new(request.env['omniauth.auth'])
    User.create_user(spotify_user)

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
