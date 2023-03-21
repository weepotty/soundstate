class UsersController < ApplicationController
  def spotify
    spotify_user = RSpotify::User.new(request.env['omniauth.auth'])
    User.create_user(spotify_user)

    combined_tracks = []
    @tracks = spotify_user.saved_tracks(offset: 0, limit: 50)
    combined_tracks.concat(@tracks)
    offset = 50

    features_array = []

    @event = Event.find(41)


    while @tracks.count == 50
      @tracks = spotify_user.saved_tracks(offset:, limit: 50)
      features_array.concat(RSpotify::AudioFeatures.find(@tracks.map(&:id)))
      # combined_tracks.concat(@tracks)
      offset += 50
    end

    copy_array = features_array.select do |feature|
      feature.acousticness.between?(@event.acousticness - 0.5, @event.acousticness + 0.5) &&
        feature.danceability.between?(@event.danceability - 0.5, @event.danceability + 0.5) &&
        feature.energy.between?(@event.energy - 0.5, @event.energy + 0.5) &&
        feature.instrumentalness.between?(@event.instrumentalness - 0.5, @event.instrumentalness + 0.5) &&
        feature.tempo.between?(@event.tempo - 40, @event.tempo + 40) &&
        feature.valence.between?(@event.valence - 0.5, @event.valence + 0.5)
    end

raise
  end
end
