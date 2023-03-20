class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events do |t|
      t.string :title, null: false
      t.float :acousticness, null: false
      t.float :danceability, null: false
      t.float :energy, null: false
      t.float :instrumentalness, null: false
      t.float :liveness, null: false
      t.float :speechiness, null: false
      t.float :tempo, null: false
      t.float :valence, null: false
      t.float :popularity, null: false
      t.integer :time, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
