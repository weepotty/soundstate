class Playlist < ApplicationRecord
  belongs_to :user
  has_one_attached :photo
  has_many :songs

  validates :title, presence: true, length: { maximum: 25 }


  def create_playlist
    user_tracks = spotify_user.saved_tracks
    playlist = user_tracks
  end
end
