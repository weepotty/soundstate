class AddAccessTokenToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :access_token, :jsonb
  end
end
