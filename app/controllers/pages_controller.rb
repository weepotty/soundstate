class PagesController < ApplicationController
  def home
    @user = User.find(115)
    @event = Event.find(439)

    @playlist = @user.songs.select do |song|
      song.acousticness.between?(@event.min_acousticness, @event.max_acousticness) &&
        song.danceability.between?(@event.min_danceability, @event.max_danceability) &&
        song.energy.between?(@event.min_energy, @event.max_energy) &&
        song.tempo.between?(@event.min_tempo, @event.max_tempo) &&
        song.valence.between?(@event.min_valence, @event.max_valence)
    end

    # get the spotify song URIs and create a playlist with these +/- store in user's spotify
    # play the playlist


    render ( user_signed_in? ? 'pages/home' : 'pages/landing')
  end
end
