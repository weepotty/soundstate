class UpdatePlaylistsJob < ApplicationJob
  queue_as :default

  def perform(user)
    user.playlists.each do |playlist|
      playlist.destroy if RSpotify::Playlist.find_by_id(playlist.spotify_id).public
    end
  end
end
