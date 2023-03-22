class CreatePlaylistsSongs < ActiveRecord::Migration[7.0]
  def change
    create_table :playlists_songs do |t|
      t.references :playlist, null: false, foreign_key: true
      t.references :song, null: false, foreign_key: true

      t.timestamps
    end
  end
end
