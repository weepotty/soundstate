class ImportSongRecommendationsService
  def self.call(current_user:)
    new(current_user:).call
  end

  def initialize(current_user:)
    @current_user = current_user
    @spotify_user = current_user.spotify_user
  end

  def call
    import_song_recommendations
  end

  private

  attr_reader :current_user, :spotify_user

  def import_song_recommendations
    fetch_track_recommendations.each do |track|
        # for each track, check if it's already in the DB, if not create the song
        song = Song.find_by(spotify_id: track.id) 
        song = create_song(track) if song.nil? 
  
        # check if song-user combo exists, if not insert that into the join table
        # update the updated_at, so we can use it to remove songsUser that are not updated (not in user's liked songs)
        SongsUser.find_or_create_by(song: song, user: current_user).touch
    end
  end

  def fetch_track_recommendations
    seed_artists = get_top_artists(5)
    recommendations_from_artists = RSpotify::Recommendations.generate(limit: 100, seed_artists:).tracks
    
    seed_tracks = get_top_tracks(5)
    recommendations_from_tracks = RSpotify::Recommendations.generate(limit: 100, seed_tracks:).tracks

    recommendations_from_artists.concat(recommendations_from_tracks)
  end

  def get_top_artists(count)
    artists = spotify_user.top_artists(limit: count, offset: 0, time_range: "short_term")

    artists.map { |artist| artist.id }
  end

  def get_top_tracks(count)
    tracks = spotify_user.top_tracks(limit: count, offset: 0, time_range: "short_term")

    tracks.map { |track| track.id }
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