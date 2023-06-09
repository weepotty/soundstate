class Playlist < ApplicationRecord
  belongs_to :user
  has_one_attached :photo
  has_many :playlists_songs, dependent: :destroy
  has_many :songs, through: :playlists_songs

  validates :title, presence: true, length: { maximum: 25 }


  def create_playlist
    user_tracks = spotify_user.saved_tracks
    playlist = user_tracks
  end

  def change_share
    @is_shared = true
  end
end
