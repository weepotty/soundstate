class RemoveSpotifyIdFromPlaylists < ActiveRecord::Migration[7.0]
  def change
    remove_column :playlists, :spotify_id, :string, null: false
  end
end
