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

  def import_songs
    offset = 0
    loop do
      tracks = ::ImportSongsByBatchService.call(spotify_user:, current_user:, offset:)
      offset += tracks.count

      break if (tracks.count < 50 || offset >= 200)
    end

    if offset >= 200
      ::ImportAllSongsJob.perform_later(current_user:, offset:) 
    end
  end
end
