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

    # filepath = '/Users/shona/code/weepotty/soundstate/db/songs.csv'

    # CSV.open(filepath, "a") do |csv|
    #   tracks_array.each do |track|
    #     features = RSpotify::AudioFeatures.find(track.id) # gives us back audio features for that track
    #     csv_row = [track.id, track.name, track.uri, track.artists.first.name, features.acousticness, features.danceability,features.energy, features.instrumentalness, features.tempo, features.valence]
    #     csv << csv_row
    #   end
    # end

    # if user has more than 50 songs in library, keep fetching audio features

    # # filter the audio features according to event's filters

    # filtered_array = features_array.select do |feature|
    #   feature.acousticness.between?(@event.acousticness - 0.5, @event.acousticness + 0.5) &&
    #     feature.danceability.between?(@event.danceability - 0.5, @event.danceability + 0.5) &&
    #     feature.energy.between?(@event.energy - 0.5, @event.energy + 0.5) &&
    #     feature.instrumentalness.between?(@event.instrumentalness - 0.5, @event.instrumentalness + 0.5) &&
    #     feature.tempo.between?(@event.tempo - 40, @event.tempo + 40) &&
    #     feature.valence.between?(@event.valence - 0.5, @event.valence + 0.5)
    # end


    # get the spotify song URIs from the filtered_array and create a playlist with these +/- store in user's spotify
    # play the playlist

  end

end
