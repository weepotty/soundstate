class AddTitleToPlaylists < ActiveRecord::Migration[7.0]
  def change
    add_column :playlists, :title, :string, null: false
  end
end
