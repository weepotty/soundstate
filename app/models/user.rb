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
  def self.create_user(spotify_user)
    account = User.where(email: spotify_user.email).first
    account ||= User.new(email: spotify_user.email, password: Devise.friendly_token[0, 20], nickname: spotify_user.display_name)
    account.save!
    account
  end
end
