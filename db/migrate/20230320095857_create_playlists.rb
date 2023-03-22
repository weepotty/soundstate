class CreatePlaylists < ActiveRecord::Migration[7.0]
  def change
    create_table :playlists do |t|
      t.boolean :is_favourite, default: false

      t.references :event, null: false, foreign_key: true
      t.timestamps
    end
  end
end
