class User < ApplicationRecord
  include PgSearch::Model

  has_many :events, dependent: :destroy
  has_many :playlists, dependent: :destroy
  has_many :songs_users, dependent: :destroy
  has_many :songs, through: :songs_users
  has_one_attached :avatar

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

      if !spotify_user.images.empty?
        require "open-uri"
        avatar = URI.open(spotify_user.images.first.url)
        filename = spotify_user.images.first.url.match(/\/image\/(.+)/)[1]
        account.avatar.attach(io: avatar, filename: "#{filename}.jpg", content_type: "image/jpg")
        account.save
      end
      account.add_default_events
    end
    account
  end

  def spotify_user
    RSpotify::User.new(spotify_auth)
  end

  def user_playlists
    Playlist.where(user: self).order(created_at: :desc)
  end

  def others_playlists
    Playlist.where(is_shared: true).where.not(user: self).order(updated_at: :desc)
  end

  def new_user?
    # User created within the last 60 seconds
    (Time.now - created_at) <= 60
  end

  private

  # Add 3 default events to new users
  def add_default_events
    Event.create!(
      title: 'Getting ready',
      min_acousticness: 0.0,
      max_acousticness: 1.0,
      min_danceability: 0.6,
      max_danceability: 0.9,
      min_energy: 0.6,
      max_energy: 1.0,
      min_tempo: 100,
      max_tempo: 180,
      min_valence: 0.4,
      max_valence: 0.9,
      time: 0,
      user: self
    )

    Event.create!(
      title: 'Acoustic',
      min_acousticness: 0.8,
      max_acousticness: 1.0,
      min_danceability: 0.0,
      max_danceability: 1.0,
      min_energy: 0.0,
      max_energy: 1.0,
      min_tempo: 50,
      max_tempo: 200,
      min_valence: 0.0,
      max_valence: 1.0,
      time: 1,
      user: self
    )

    Event.create!(
      title: 'Sleep',
      min_acousticness: 0.0,
      max_acousticness: 1.0,
      min_danceability: 0.0,
      max_danceability: 0.5,
      min_energy: 0.0,
      max_energy: 0.2,
      min_tempo: 80,
      max_tempo: 180,
      min_valence: 0.0,
      max_valence: 1.0,
      time: 2,
      user: self
    )
  end
end
