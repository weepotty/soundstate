class Event < ApplicationRecord
  belongs_to :user
  has_one_attached :photo

  validates :title, presence: true, length: { maximum: 25 }
  validates_presence_of %i[min_acousticness min_danceability min_energy min_tempo min_valence max_acousticness max_danceability max_energy max_tempo max_valence]
  validates :time, presence: true
  enum time: %i[morning afternoon evening]

  def filter_songs(user)
    songs = user.songs.where(
      acousticness: min_acousticness..max_acousticness,
      danceability: min_danceability..max_danceability,
      energy: min_energy..max_energy,
      tempo: min_tempo..max_tempo,
      valence: min_valence..max_valence
    )
    
    # Sample the first 100 songs from the filters. If we filtered to less than 100 songs, all songs selected would be randomized.
    songs = songs.sample(100)

    song_uris = []
    songs.each do |song|
      song_uris << song.uri
    end

    [songs, song_uris]
  end
end
