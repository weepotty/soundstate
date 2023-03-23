class User < ApplicationRecord
  has_many :events, dependent: :destroy
  has_many :playlists, dependent: :destroy
  has_many :songs_users, dependent: :destroy
  has_many :songs, through: :songs_users

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, presence: true, uniqueness: true

  def self.create_from_spotify(spotify_user, access_token)
    account = User.where(email: spotify_user.email).first
    if account
      return account if account.access_token == access_token

      account.update!(access_token:)
    else
      account = User.create!(email: spotify_user.email, password: Devise.friendly_token[0, 20], nickname: spotify_user.display_name, access_token:)
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
    RSpotify::User.new(access_token)
  end
end
