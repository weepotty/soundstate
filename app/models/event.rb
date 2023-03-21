class Event < ApplicationRecord
  belongs_to :user

  validates :title, presence: true, length: { maximum: 25 }
  validates_presence_of %i[acousticness danceability energy instrumentalness liveness speechiness tempo valence popularity]
  validates :time, presence: true
  enum time: %i[morning afternoon evening]
end
