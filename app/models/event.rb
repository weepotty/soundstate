class Event < ApplicationRecord
  belongs_to :user

  validates :title, presence: true, length: { maximum: 25 }
  validates %i[acousticness danceability energy instrumentalness liveness speechiness tempo valence popularity], presence: true
  validates :time, presence: true
  enum time: %i[morning afternoon evening]
end
