class User < ApplicationRecord
  include PgSearch::Model

  has_many :events, dependent: :destroy
  has_many :playlists, dependent: :destroy
  has_many :songs_users, dependent: :destroy
  has_many :songs, through: :songs_users

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, presence: true, uniqueness: true

  pg_search_scope :search_by_nickname,
    against: [ :nickname ],
    using: {
      tsearch: { prefix: true }
    }

  def self.create_from_spotify(spotify_user, spotify_auth)
    account = User.where(email: spotify_user.email).first
    if account
      return account if account.spotify_auth == spotify_auth

      account.update!(spotify_auth:)
    else
      account = User.create!(email: spotify_user.email, password: Devise.friendly_token[0, 20], nickname: spotify_user.display_name, spotify_auth:)
      # create 3 default events here!
    end
    account
  end

  def self.user_tracks
    @tracks = @spotify_user.saved_tracks(offset: 0, limit: 50)
    tracks_array = @tracks
    offset = 50
    while @tracks.count == 50
      @tracks = @spotify_user.saved_tracks(offset:, limit: 50)
      tracks_array.concat(@tracks)
      offset += 50
    end
  end

  def spotify_user
    RSpotify::User.new(spotify_auth)
  end
end
