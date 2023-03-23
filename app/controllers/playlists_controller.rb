class PlaylistsController < ApplicationController
  def index
    @playlists = Playlist.all
    # Eager loading for when we start on image generation
    # @playlists = Playlist.includes(:image).all
  end

  def show
    # show requires an "id" variable to insert into embeded iframe
    @playlist = Playlist.includes(:spotify_id).find(params[:id])
  end

  def new
    # access user's account
    spotify_user = current_user.spotify_user

    # create instance of playlist to spotify
    @spotify_playlist = spotify_user.create_playlist!('2nd Best PLaylist Ever')


    # create instance of playlist on our database store songs
    @ss_playlist = Playlist.new()

    # get the event that we will filter the songs by
    @event = Event.first # to be dynamic once slider and stuffs are done

    # filter the user's songs with event
    filter_songs(@event)


    # add tracks to spotify playlist by
    @spotify_playlist.add_tracks!(@song_uris.sample(100))
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
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
  end
end
