class AddColumnsToEvent < ActiveRecord::Migration[7.0]
  def change
    add_column :events, :min_acousticness, :float, null: false
    add_column :events, :min_danceability, :float, null: false
    add_column :events, :min_energy, :float, null: false
    add_column :events, :min_instrumentalness, :float, null: false
    add_column :events, :min_tempo, :float, null: false
    add_column :events, :min_valence, :float, null: false
  end
end
