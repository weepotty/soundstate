class User < ApplicationRecord
  has_many :events, dependent: :destroy
  has_many :playlists, dependent: :destroy
  has_many :songs

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
end
