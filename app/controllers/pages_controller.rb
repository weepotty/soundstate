class PagesController < ApplicationController
  def home

    @user = User.first
    @event = Event.first

    @playlist = @user.songs.where(
      acousticness: @event.min_acousticness..@event.max_acousticness,
      danceability: @event.min_danceability..@event.max_danceability,
      energy: @event.min_energy..@event.max_energy,
      tempo: @event.min_tempo..@event.max_tempo,
      valence: @event.min_valence..@event.max_valence
    )
    # get the spotify song URIs and create a playlist with these +/- store in user's spotify
    # play the playlist

    render ( user_signed_in? ? 'pages/home' : 'pages/landing')

  end
end
