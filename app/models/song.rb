class Song < ApplicationRecord
  has_many :playlists_songs
  has_many :songs_users, dependent: :destroy

  validates_presence_of %i[spotify_id acousticness danceability energy tempo valence]
end
