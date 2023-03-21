class Playlist < ApplicationRecord
  belongs_to :user

  validates :title, presence: true, length: { maximum: 25 }
  validates :spotify_id, presence: true


  def create_playlist
    user_tracks = spotify_user.saved_tracks
    playlist = user_tracks
  end
end
