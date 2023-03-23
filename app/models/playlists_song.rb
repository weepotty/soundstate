class PlaylistsSong < ApplicationRecord
  belongs_to :playlist
  belongs_to :song

  validates :playlist, presence: true
  validates :song, presence: true
  validates :playlist, uniqueness: { scope: :song }
end
