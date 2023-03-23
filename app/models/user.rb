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

  def self.create_user(spotify_user)
    account = User.where(email: spotify_user.email).first
    account ||= User.new(email: spotify_user.email, password: Devise.friendly_token[0, 20], nickname: spotify_user.display_name)
    account.save!
    account
  end

  def self.initiate_spotify(auth)
    @spotify_user = RSpotify::User.new(auth)
  end

  def self.spotify_user
    @hash = @spotify_user.to_hash
    RSpotify::User.new(@hash)
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
end
