class ChangeIsFavouriteToIsShared < ActiveRecord::Migration[7.0]
  def change
    rename_column(:playlists, :is_favourite, :is_shared)
  end
end
