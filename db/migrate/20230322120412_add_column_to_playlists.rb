class AddColumnToPlaylists < ActiveRecord::Migration[7.0]
  def change
    add_column :playlists, :spotify_id, :string, null: false
  end
end
