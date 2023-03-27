class PlaylistsController < ApplicationController
  # GET /users/:user_id/playlists
  def index
    @user = User.find(params[:user_id])
    @playlists = Playlist.where(user: @user)
    # Eager loading for when we start on image generation
    # @playlists = Playlist.includes(:image).all
  end

  # GET /playlists/:id
  def show
    # show requires an "id" variable to insert into embeded iframe
    @playlist = Playlist.find(params[:id])
  end

  # GET /events/:event_id/playlists/new
  def new
    @playlist = Playlist.new
    @event = Event.find(params[:event_id])
    filter_songs(@event)
  end

  # POST /events/:event_id/playlists
  def create
    # access user's account
    spotify_user = current_user.spotify_user
    @playlist = Playlist.new
    @event = Event.find(params[:event_id])
    filter_songs(@event)

    # create instance of playlist to spotify
    @spotify_playlist = spotify_user.create_playlist!(playlist_params[:title])
    rescue RestClient::BadRequest
      flash[:alert] = "Please enter a Title"
      render :new, status: :bad_request
    else
      # add tracks and replace image to spotify playlist
      @spotify_playlist.add_tracks!(@song_uris)

      # @spotify_playlist.replace_image!(playlist_params[:photo], playlist_params[:photo].content_type)

      @ss_playlist = Playlist.new(title: playlist_params[:title], user: current_user, spotify_id: @spotify_playlist.id)

      if @ss_playlist.save!
        redirect_to playlist_path(@ss_playlist)
      else
        render :new, status: :unprocessable_entity
      end
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

    @songs.count > 100 ? @songs = @songs.sample(100): @songs

    @song_uris = []
    @songs.each do |song|
      @song_uris << song.uri
    end
  end

  def playlist_params
    params.require(:playlist).permit(:title)
  end
end
