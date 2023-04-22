class ImportAllSongsJob < ApplicationJob
  queue_as :default

  def perform(current_user:)
    spotify_user = current_user.spotify_user
    offset = 0
    loop do
      tracks = ::ImportSongsByBatchService.call(spotify_user:, current_user:, offset:)
      offset += tracks.count

      break if (tracks.count < 50)
    end
  end
end
