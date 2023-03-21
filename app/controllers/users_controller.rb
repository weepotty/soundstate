class UsersController < ApplicationController
  def spotify
    spotify_user = RSpotify::User.new(request.env['omniauth.auth'])
    User.create_user(spotify_user)

    @tracks = spotify_user.saved_tracks

    features_array = RSpotify::AudioFeatures.find(@tracks.map(&:id))

    @event = Event.find(50)
    copy_array = features_array.select do |feature|
      feature.acousticness.between?(@event.acousticness - 0.2, @event.acousticness + 0.2)
        # feature.danceability.between?(@event.danceability - 0.5, @event.danceability + 0.5) &&
        # feature.energy.between?(@event.energy - 0.5, @event.energy + 0.5) &&
        # feature.instrumentalness.between?(@event.instrumentalness - 0.5, @event.instrumentalness + 0.5) &&
        # feature.tempo.between?(@event.tempo - 50, @event.tempo + 50) &&
        # feature.valence.between?(@event.valence - 0.5, @event.valence + 0.5)
    end

    raise
  end
end
