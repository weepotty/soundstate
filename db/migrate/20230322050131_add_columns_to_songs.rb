class AddColumnsToSongs < ActiveRecord::Migration[7.0]
  def change
    rename_column :songs, :track_id, :spotify_id
    add_column :songs, :name, :string, null: false
    add_column :songs, :uri, :string, null: false
    add_column :songs, :artist, :string, null: false
  end
end
