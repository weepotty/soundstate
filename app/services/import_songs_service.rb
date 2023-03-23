class ImportSongsService
  def self.call(spotify_user:, current_user:)
    @tracks = spotify_user.saved_tracks(offset: 0, limit: 50)
    all_tracks = @tracks
    offset = 50
    while @tracks.count == 50
      @tracks = spotify_user.saved_tracks(offset:, limit: 50)
      all_tracks.concat(@tracks)
      offset += 50
    end

    insert_songs(all_tracks, current_user)

    # get the spotify song URIs from the filtered_array and create a playlist with these +/- store in user's spotify
    # play the playlist
  end

  def self.insert_songs(all_tracks, current_user)
    all_tracks.each do |track|
      # for each track, check if it's already in the DB, if not create the song
      @song = Song.find_or_create_by(spotify_id: track.id) do |song|
        features = RSpotify::AudioFeatures.find(track.id)
        song.acousticness = features.acousticness
        song.danceability = features.danceability
        song.energy = features.energy
        song.tempo = features.tempo
        song.valence = features.valence
        song.name = track.name
        song.uri = track.uri
        song.artist = track.artists.first.name
      end

      # check if song-user combo exists, if not insert that into the join table
      SongsUser.find_or_create_by(song: @song, user: current_user)
    end
  end
end
