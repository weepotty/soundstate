class UpdatePlaylistsJob < ApplicationJob
  queue_as :default

  def perform(current_user:)
    current_user.playlists.each do |playlist|
      playlist.destroy unless RSpotify::Playlist.find_by_id(playlist.spotify_id).public
    end
  end
end
