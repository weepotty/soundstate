class PagesController < ApplicationController
  def home
    @user = User.find(111)
    @event = Event.create!(
      title: 'Acoustic',
      min_acousticness: 0.8,
      max_acousticness: 1.0,
      min_danceability: 0.0,
      max_danceability: 1.0,
      min_energy: 0.0,
      max_energy: 1.0,
      min_tempo: 50,
      max_tempo: 200,
      min_valence: 0.0,
      max_valence: 1.0,
      time: 1,
      user: @user
    )
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
