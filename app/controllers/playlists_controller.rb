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

      @ss_playlist = Playlist.new(title: playlist_params[:title], user: current_user, spotify_id: @spotify_playlist.id)

      # Using OpenAI gem to generate image from the Song instance object.
      # Here, we use the first song in the playlist to generate the image.
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

  # Private method to generate image from the Song instance object, returns an image url.
  def generate_image(song, event)
    # Generate the prompt from the Song instance object.
    prompt = generate_prompt(song)

    # Various prompt helper words for better image generation results.
    art_styles = ['pop art', 'risograph', 'illustration', 'colouring-in sheet', 'cubism', 'memphis', 'digital art',
                  '3D render', 'block printing', 'watercolor', 'synthwave', 'ceramics', 'vaporwave', 'linocut art']

    # Generate image and returns image url.
    client = OpenAI::Client.new
    image_response = client.images.generate(parameters: { prompt: "#{prompt}, #{mood_descriptors(event).sample(2).join(', ')}, in the art style of #{art_styles.sample}", size: "256x256" })

    img_res = image_response.dig('data', 0, 'url')
  end

  # private method to select mood descriptors based on filter
  def mood_descriptors(event)
    # happy energetic
    if event.max_valence > 0.5 && event.max_energy > 0.5
      %w[bright vibrant dynamic spirited vivid lively energetic colorful joyful romantic expressive rich]
    # happy chill
    elsif event.max_valence > 0.5 && event.max_energy < 0.5
      %w[light peaceful calm serene soothing relaxed cosy tranquil pastel ethereal tender soft]
    # sad chill
    elsif event.max_valence < 0.4
      %w[winter somber melancholic sad gothic post-apocalyptic]
    # discordant moods
    else
      %w[sublime symmetrical vibrant vivid poignant]
    end
  end

  # Private method to generate prompt from the Song instance object.
  def generate_prompt(song)
    query = "Return a string of the meaning of the song #{song.name} by #{song.artist}. Limit to 10 words."

    client = OpenAI::Client.new
    response = client.chat(
      parameters: {
        model: 'gpt-3.5-turbo', # Required.
        messages: [{ role: 'user', content: query }], # Required.
        temperature: 0.7
      }
    )
    response.dig('choices', 0, 'message', 'content')
  end
end
