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
    @songs, @song_uris = @event.filter_songs(current_user)

    # make empty playlist in spotify playlist
    spotify_user = current_user.spotify_user
    spotify_playlist = spotify_user.create_playlist!(playlist_params[:title])

    # add tracks to spotify
    spotify_playlist.add_tracks!(@song_uris)

    # add playlist to our DB
    @ss_playlist = Playlist.new(title: playlist_params[:title], user: current_user, spotify_id: spotify_playlist.id)

    # generate image URL
    image_url = ::GenerateImageService.call(
      song: @songs.sample,
      event: @event
    )
    playlist_image = URI.open(image_url)

    # attaching AI image to our DB
    @ss_playlist.photo.attach(io: playlist_image, filename: "#{@ss_playlist.title}.png", content_type: "image/png")

    if @ss_playlist.save!
      # As Spotify only accepts jpeg in Base64 string format, we would need to use Cloudinary to convert the uploaded png from OpenAI into jpeg.
      # Then, we would need to use strict_encode64.
      jpeg_image = URI.open("#{@ss_playlist.photo.url[...-4]}.jpeg") { |io| io.read }

      # replace spotify playlist image with AI generated one
      spotify_playlist.replace_image!(Base64.strict_encode64(jpeg_image), 'image/jpeg')

      redirect_to playlist_path(@ss_playlist)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def toggle_shared
    @playlist = Playlist.find(params[:playlist_id])
    @playlist.update(is_shared: !@playlist.is_shared)
    @playlist.save!

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
end
