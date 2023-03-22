# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or create!d alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create!([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create!(name: "Luke", movie: movies.first)

require 'csv'

puts "destroying data..."
PlaylistsSong.destroy_all
SongsUser.destroy_all
Event.destroy_all
Playlist.destroy_all
User.destroy_all

puts 'planting new seeds'

user1 = User.create!(email: 'frank@frankdev.com', password: '123456', nickname: 'frank')
user2 = User.create!(email: 'sally@sallydev.com', password: '123456', nickname: 'sally')
user3 = User.create!(email: 'bob@bobdev.com', password: '123456', nickname: 'bob')
user4 = User.create!(email: 'carol@caroldev.com', password: '123456', nickname: 'carol')
user5 = User.create!(email: 'alice@alicedev.com', password: '123456', nickname: 'alice')

users = [user1, user2, user3, user4, user5]

users.each do |user|
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
    user:
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
    user:
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
    user:
  )
end



filepath = 'db/songs.csv'

CSV.foreach(filepath, headers: :first_row) do |row|
  Song.create!(spotify_id: row['spotify_id'], name: row['name'], uri: row['uri'], artist: row['artist'], acousticness: row['acousticness'], danceability: row['danceability'], energy: row['energy'], tempo: row['tempo'], valence: row['valence'])
end

playlist1 = Playlist.create!(title: 'watering flowers', user: user1, is_shared: true)
playlist2 = Playlist.create!(title: 'George & Indiana', user: user2)
playlist3 = Playlist.create!(title: 'Stretching', user: user3, is_shared: true)
playlist4 = Playlist.create!(title: 'SHUIJIAO', user: user4, is_shared: true)
playlist5 = Playlist.create!(title: 'secret yoga', user: user5, is_shared: true)

Song.all.sample(200).each do |song|
  PlaylistsSong.create!(playlist: playlist1, song:)
  SongsUser.create!(song:, user: user1)
end

Song.all.sample(200).each do |song|
  PlaylistsSong.create!(playlist: playlist2, song:)
  SongsUser.create!(song:, user: user2)
end

Song.all.sample(200).each do |song|
  PlaylistsSong.create!(playlist: playlist3, song:)
  SongsUser.create!(song:, user: user3)
end

Song.all.sample(200).each do |song|
  PlaylistsSong.create!(playlist: playlist4, song:)
  SongsUser.create!(song:, user: user4)
end

Song.all.sample(200).each do |song|
  PlaylistsSong.create!(playlist: playlist5, song:)
  SongsUser.create!(song:, user: user5)
end

# puts 'seeded like a lovely garden'
