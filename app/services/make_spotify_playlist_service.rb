class MakeSpotifyPlaylistService
  def self.call(event:, current_user:, playlist_params:, image_url:)
    playlist_image = URI.open(image_url)
    # @event, current_user, @ss_playlist
    songs, song_uris = event.filter_songs(current_user)
    # make empty playlist in spotify playlist
    spotify_user = current_user.spotify_user
    spotify_playlist = spotify_user.create_playlist!(playlist_params[:title])
    # add tracks to spotify
    spotify_playlist.add_tracks!(song_uris)

    # add playlist to our DB
    ss_playlist = Playlist.new(title: playlist_params[:title], user: current_user, spotify_id: spotify_playlist.id)

    # attaching AI image to our DB
    ss_playlist.photo.attach(io: playlist_image, filename: "#{ss_playlist.title}.png", content_type: "image/png")
    return [ss_playlist, spotify_playlist]
  end
end
