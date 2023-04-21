class ImportSongsService
  def self.call(spotify_user:, current_user:)
    new(spotify_user:, current_user:).call
  end

  def initialize(spotify_user:, current_user:)
    @spotify_user = spotify_user
    @current_user = current_user
  end

  def call
    import_songs
  end

  private

  attr_reader :spotify_user, :current_user

  def fetch_all_tracks
    all_tracks = []
    offset = 0

    loop do
      tracks = spotify_user.saved_tracks(offset:, limit: 50)
      all_tracks.concat(tracks)
      offset += 50
      
      # Limit import songs to 400, to limit api request.
      break unless (tracks.count == 50 && offset < 400)
    end

    return all_tracks
  end

  def import_songs
    fetch_all_tracks.each do |track|
      # for each track, check if it's already in the DB, if not create the song
      song = Song.find_by(spotify_id: track.id) 
      song = create_song(track) if song.nil? 

      # check if song-user combo exists, if not insert that into the join table
      SongsUser.find_or_create_by(song: song, user: current_user)
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
