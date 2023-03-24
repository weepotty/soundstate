class PlaylistsController < ApplicationController
  # GET /users/:user_id/playlists
  def index
    @playlists = Playlist.all
    # Eager loading for when we start on image generation
    # @playlists = Playlist.includes(:image).all
  end

  # GET /playlists/:id
  def show
    # show requires an "id" variable to insert into embeded iframe
    @playlist = Playlist.includes(:spotify_id).find(params[:id])
  end

  # GET /events/:event_id/playlists/new
  def new
    @playlist = Playlist.new
    # get the event that we will filter the songs by
    @event = Event.find(params[:event_id])

    # filter the user's songs with event
    filter_songs(@event)

    @song_uris

    @tracks = RSpotify::Base.find(@song_ids.first(20), 'track')
  end

  # POST /events/:event_id/playlists
  def create
    # access user's account
    spotify_user = current_user.spotify_user

    # create instance of playlist to spotify
    @spotify_playlist = spotify_user.create_playlist!(playlist_params.title)

    # add tracks to spotify playlist by
    @spotify_playlist.add_tracks!(@song_uris.sample(100))

    # create instacne of playlist in out database
    # no image yet!
    @ss_playlist = Playlist.create!(title: playlist_params.title, user: current_user, spotify_id: @spotify_playlist.id)
  end

  private

  def filter_songs(event)
    @songs = current_user.songs.where(
      acousticness: event.min_acousticness..event.max_acousticness,
      danceability: event.min_danceability..event.max_danceability,
      energy: event.min_energy..event.max_energy,
      tempo: event.min_tempo..event.max_tempo,
      valence: event.min_valence..event.max_valence
    )

    @song_uris = []
    @songs.each do |song|
      @song_uris << song.uri
    end

    @song_ids = []
    @songs.each do |song|
      @song_ids << song.spotify_id
    end
  end

  def playlist_params
    params.require(:playlist).permit(:title)
  end
end
