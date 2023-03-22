class CreateSongs < ActiveRecord::Migration[7.0]
  def change
    create_table :songs do |t|
      t.string :track_id, null: false
      t.float :acousticness, null: false
      t.float :danceability, null: false
      t.float :energy, null: false
      t.float :instrumentalness, null: false
      t.float :tempo, null: false
      t.float :valence, null: false

      t.timestamps
    end
  end
end
