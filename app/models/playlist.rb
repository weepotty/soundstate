class Playlist < ApplicationRecord
  belongs_to :user

  validates :title, presence: true, length: { maximum: 25 }
  validates :spotify_id, presence: true
end
