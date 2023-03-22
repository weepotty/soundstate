class AddUserIdToPlaylists < ActiveRecord::Migration[7.0]
  def change
    add_reference :playlists, :user, index: true, foreign_key: true, null: false
  end
end
