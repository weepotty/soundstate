class Song < ApplicationRecord
  has_many :playlists
  has_many :users

  validates_presence_of %i[track_id acousticness danceability energy instrumentalness tempo valence]
end
