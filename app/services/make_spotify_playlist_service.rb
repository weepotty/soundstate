class MakeSpotifyPlaylistService
  def self.call(song_uris:, current_user:, playlist_params:, image_url:)
    new(song_uris:, current_user:, playlist_params:, image_url:).call
  end
  
  def initialize(song_uris:, current_user:, playlist_params:, image_url:)
    @song_uris = song_uris
    @current_user = current_user 
    @playlist_params = playlist_params
    @image_url = image_url
  end

  def call
    spotify_playlist = create_spotify_playlist
    local_playlist = create_local_playlist(spotify_playlist)

    return [local_playlist, spotify_playlist]
  end

  private

  attr_reader :song_uris, :current_user, :playlist_params, :image_url

  def create_spotify_playlist
    # make empty playlist in spotify playlist
    spotify_playlist = spotify_user.create_playlist!(playlist_params[:title])
    # add tracks to spotify (add_tracks! returns array of RSpotify tracks instances)
    spotify_playlist.add_tracks!(song_uris)

    return spotify_playlist
  end

  def create_local_playlist(spotify_playlist)
    local_playlist = Playlist.new(title: playlist_params[:title], user: current_user, spotify_id: spotify_playlist.id)

    attach_image_to_local_playlist(local_playlist)

    return local_playlist
  end

  def attach_image_to_local_playlist(local_playlist)
    local_playlist.photo.attach(io: playlist_image, filename: "#{local_playlist.title}.png", content_type: "image/png")
  end

  def spotify_user
    @spotify_user ||= current_user.spotify_user
  end

  def playlist_image
    URI.open(image_url)
  end
end
