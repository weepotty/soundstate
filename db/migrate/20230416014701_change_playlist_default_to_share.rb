class ChangePlaylistDefaultToShare < ActiveRecord::Migration[7.0]
  def change
    change_column_default :playlists, :is_shared, from: false, to: true
  end
end
