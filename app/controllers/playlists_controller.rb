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
end
