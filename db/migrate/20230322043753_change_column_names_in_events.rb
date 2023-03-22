class ChangeColumnNamesInEvents < ActiveRecord::Migration[7.0]
  def change
    rename_column :events, :acousticness, :max_acousticness
    rename_column :events, :danceability, :max_danceability
    rename_column :events, :energy, :max_energy
    rename_column :events, :instrumentalness, :max_instrumentalness
    rename_column :events, :tempo, :max_tempo
    rename_column :events, :valence, :max_valence
  end
end
