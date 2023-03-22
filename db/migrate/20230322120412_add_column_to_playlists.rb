class AddColumnToPlaylists < ActiveRecord::Migration[7.0]
  def change
    add_column :playlists, :spotify_id, :string, default: '', null: false
  end
end
