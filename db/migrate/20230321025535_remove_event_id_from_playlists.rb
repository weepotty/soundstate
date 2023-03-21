class RemoveEventIdFromPlaylists < ActiveRecord::Migration[7.0]
  def change
    remove_reference :playlists, :event, index: true, foreign_key: true
  end
end
