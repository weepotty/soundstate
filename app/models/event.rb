class Event < ApplicationRecord
  belongs_to :user
  has_one_attached :photo

  validates :title, presence: true, length: { maximum: 25 }
  validates_presence_of %i[min_acousticness min_danceability min_energy min_tempo min_valence max_acousticness max_danceability max_energy max_tempo max_valence]
  validates :time, presence: true
  enum time: %i[morning afternoon evening]


  def filter_songs(current_user)
    songs = current_user.songs.where(
      acousticness: min_acousticness..max_acousticness,
      danceability: min_danceability..max_danceability,
      energy: min_energy..max_energy,
      tempo: min_tempo..max_tempo,
      valence: min_valence..max_valence
    )

    songs.count > 100 ? songs = songs.sample(100) : songs

    song_uris = []
    songs.each do |song|
      song_uris << song.uri
    end

    [songs, song_uris]
  end



  # def filter_songs(event)
  #   @songs = current_user.songs.where(
  #     acousticness: event.min_acousticness..event.max_acousticness,
  #     danceability: event.min_danceability..event.max_danceability,
  #     energy: event.min_energy..event.max_energy,
  #     tempo: event.min_tempo..event.max_tempo,
  #     valence: event.min_valence..event.max_valence
  #   )

  #   @songs.count > 100 ? @songs = @songs.sample(100) : @songs

  #   @song_uris = []
  #   @songs.each do |song|
  #     @song_uris << song.uri
  #   end
  # end
end
