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

    #returns AI image url
    @ai_image_url = ::GenerateImageService.call(
      song: filter_songs(@event).sample,
      event: @event
    )
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

      @ss_playlist = Playlist.new(title: playlist_params[:title], user: current_user, spotify_id: @spotify_playlist.id)


      # attaching AI image to our playlist database
      require "open-uri"
      playlist_image = URI.open(generate_image(@songs.sample, @event))
      @ss_playlist.photo.attach(io: playlist_image, filename: "#{@ss_playlist.title}.png", content_type: "image/png")

      if @ss_playlist.save!
        # As Spotify only accepts jpeg in Base64 string format, we would need to use Cloudinary to convert the uploaded png from OpenAI into jpeg.
        # Then, we would need to use strict_encode64.
        jpeg_image = URI.open("#{@ss_playlist.photo.url[...-4]}.jpeg") { |io| io.read }
        @spotify_playlist.replace_image!(Base64.strict_encode64(jpeg_image), 'image/jpeg')

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

  def filter_songs(event)
    @songs = current_user.songs.where(
      acousticness: event.min_acousticness..event.max_acousticness,
      danceability: event.min_danceability..event.max_danceability,
      energy: event.min_energy..event.max_energy,
      tempo: event.min_tempo..event.max_tempo,
      valence: event.min_valence..event.max_valence
    )

    @songs.count > 100 ? @songs = @songs.sample(100) : @songs

    @song_uris = []
    @songs.each do |song|
      @song_uris << song.uri
    end
  end

  def playlist_params
    params.require(:playlist).permit(:title)
  end

  def shared_params
    params.require(:playlist).permit(:is_shared)
  end
end
