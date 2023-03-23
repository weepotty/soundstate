class ChangeColumnNameUsers < ActiveRecord::Migration[7.0]
  def change
    rename_column :users, :access_token, :spotify_auth
  end
end
