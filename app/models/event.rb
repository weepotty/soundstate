class Event < ApplicationRecord
  belongs_to :user
  has_one_attached :photo

  validates :title, presence: true, length: { maximum: 25 }
  validates_presence_of %i[min_acousticness min_danceability min_energy min_instrumentalness min_tempo min_valence max_acousticness max_danceability max_energy max_instrumentalness max_tempo max_valence]
  validates :time, presence: true
  enum time: %i[morning afternoon evening]
end
