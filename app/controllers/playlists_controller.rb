require "open-uri"
class PlaylistsController < ApplicationController
  skip_before_action :verify_authenticity_token

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
    @songs, @song_uris = @event.filter_songs(current_user)

    if @songs.count < 100
      update_with_song_recommendations(event: @event)
    end
  end

  # POST /events/:event_id/playlists
  def create
    @playlist = Playlist.new
    @event = Event.find(params[:event_id])

    @ss_playlist, spotify_playlist = ::MakeSpotifyPlaylistService.call(
      current_user:,
      song_uris: song_uris_params,
      playlist_params:,
      image_url: image_params[:photo]
    )

    if @ss_playlist.save!
      # sleep delay to allow Cloudinary to update the uploaded image, and Spotify to create and add songs to playlist.
      sleep(7)

      update_spotify_playlist_image(@ss_playlist, spotify_playlist)

      # sleep delay to allow Spotify to update the uploaded image to the playlist.
      sleep(1)

      redirect_to playlist_path(@ss_playlist)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @playlist = Playlist.find(params[:id])
    @playlist.destroy!

    redirect_to users_path(current_user)
  end

  def toggle_shared
    if params[:playlist_id].nil?
      @playlist = Playlist.find(params[:id])
    else
      @playlist = Playlist.find(params[:playlist_id])
    end

    @playlist.update!(is_shared: !@playlist.is_shared)

    respond_to do |format|
      format.json { render json: { playlist: @playlist.is_shared } }
    end
  end

  private

  def playlist_params
    params.require(:playlist).permit(:title)
  end

  def shared_params
    params.require(:playlist).permit(:is_shared)
  end

  def image_params
    params.require(:playlist).permit(:photo)
  end

  def song_uris_params
    params.require(:playlist).permit(:song_uris)["song_uris"].split(',')
  end

  def update_spotify_playlist_image(ss_playlist, spotify_playlist)
    # convert to jpeg and base 64
    jpeg_image = URI.open("#{ss_playlist.photo.url[...-4]}.jpeg") { |io| io.read }
    spotify_playlist.replace_image!(Base64.strict_encode64(jpeg_image), 'image/jpeg')
  end

  def update_with_song_recommendations(event:)
    seed_tracks = current_user.spotify_user.top_tracks(limit: 20, offset: 0, time_range: "short_term").sample(5).map { |track| track.id }

    recommendations = RSpotify::Recommendations.generate(
      limit: (100 - @songs.count),
      seed_tracks:,
      min_acousticness: event.min_acousticness,
      max_acousticness: event.max_acousticness,
      min_danceability: event.min_danceability,
      max_danceability: event.max_danceability,
      min_energy: event.min_energy,
      max_energy: event.max_energy,
      min_tempo: event.min_tempo,
      max_tempo: event.max_tempo,
      min_valence: event.min_valence,
      max_valence: event.max_valence
    ).tracks

    recommendations.each do |track|
      # for each track, check if it's already in the DB, if not create the song
      song = Song.find_by(spotify_id: track.id) 
      song = create_song(track) if song.nil? 

      # skip song if song-user combo exists, prevent duplicate song in the playlist
      next if SongsUser.find_by(song: song, user: current_user)

      @songs << song
      @song_uris << song.uri
    end
  end

  def create_song(track)
    features = RSpotify::AudioFeatures.find(track.id)

    Song.create do |song|
      song.acousticness = features.acousticness
      song.danceability = features.danceability
      song.energy = features.energy
      song.tempo = features.tempo
      song.valence = features.valence
      song.spotify_id = track.id
      song.name = track.name
      song.uri = track.uri
      song.artist = track.artists.first.name
    end
  end
end
