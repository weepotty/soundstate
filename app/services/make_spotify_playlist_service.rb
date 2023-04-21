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
    playlist_image = URI.open(@image_url)
    # song_uris, current_user, @ss_playlist
    # make empty playlist in spotify playlist
    spotify_playlist = spotify_user.create_playlist!(@playlist_params[:title])
    # add tracks to spotify
    spotify_playlist.add_tracks!(@song_uris)

    # add playlist to our DB
    ss_playlist = Playlist.new(title: @playlist_params[:title], user: @current_user, spotify_id: spotify_playlist.id)

    # attaching AI image to our DB
    ss_playlist.photo.attach(io: playlist_image, filename: "#{ss_playlist.title}.png", content_type: "image/png")
    return [ss_playlist, spotify_playlist]
  end

  private

  attr_reader :song_uris, :current_user, :playlist_params, :image_url

  def spotify_user
    @spotify_user ||= current_user.spotify_user
  end
end
