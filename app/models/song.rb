class Song < ApplicationRecord

  validates_presence_of %i[track_id acousticness danceability energy instrumentalness tempo valence]
end
