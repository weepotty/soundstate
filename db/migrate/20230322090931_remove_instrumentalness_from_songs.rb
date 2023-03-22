class RemoveInstrumentalnessFromSongs < ActiveRecord::Migration[7.0]
  def change
    remove_column :songs, :instrumentalness
  end
end
