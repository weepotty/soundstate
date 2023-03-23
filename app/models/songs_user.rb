class SongsUser < ApplicationRecord
  belongs_to :song
  belongs_to :user

  validates :song, presence: true
  validates :user, presence: true
  validates :song, uniqueness: { scope: :user }
end
