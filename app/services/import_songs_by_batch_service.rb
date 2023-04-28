class ImportSongsByBatchService
  def self.call(spotify_user:, current_user:, offset:)
    new(spotify_user:, current_user:, offset:).call
  end

  def initialize(spotify_user:, current_user:, offset:)
    @spotify_user = spotify_user
    @current_user = current_user
    @offset = offset
  end

  def call
    import_songs

    return @tracks
  end

  private

  attr_reader :spotify_user, :current_user, :offset

  def fetch_tracks
    @tracks = spotify_user.saved_tracks(offset:, limit: 50)
  end

  def import_songs
    fetch_tracks.each do |track|
      # for each track, check if it's already in the DB, if not create the song
      song = Song.find_by(spotify_id: track.id) 
      song = create_song(track) if song.nil? 

      # check if song-user combo exists, if not insert that into the join table
      # update the updated_at, so we can use it to remove songsUser that are not updated (not in user's liked songs)
      SongsUser.find_or_create_by(song: song, user: current_user).touch
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