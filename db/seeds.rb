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
    min_acousticness: 0.2,
    max_acousticness: 0.5,
    min_danceability: 0.6,
    max_danceability: 0.9,
    min_energy: 0.6,
    max_energy: 0.9,
    min_instrumentalness: 0.2,
    max_instrumentalness: 0.8,
    min_tempo: 100,
    max_tempo: 180,
    min_valence: 0.4,
    max_valence: 0.9,
    time: 0,
    user:
  )

  Event.create!(
    title: 'Commuting',
    min_acousticness: 0.1,
    max_acousticness: 0.9,
    min_danceability: 0.6,
    max_danceability: 1.0,
    min_energy: 0.7,
    max_energy: 1.0,
    min_instrumentalness: 0.1,
    max_instrumentalness: 0.9,
    min_tempo: 80,
    max_tempo: 180,
    min_valence: 0.8,
    max_valence: 1.0,
    time: 0,
    user:
  )

  Event.create!(
    title: 'Focusing',
    min_acousticness: 0.0,
    max_acousticness: 1.0,
    min_danceability: 0.0,
    max_danceability: 0.5,
    min_energy: 0.0,
    max_energy: 0.5,
    min_instrumentalness: 0.5,
    max_instrumentalness: 1.0,
    min_tempo: 50,
    max_tempo: 200,
    min_valence: 0.0,
    max_valence: 1.0,
    time: 1,
    user:
  )

  Event.create!(
    title: 'Exercising',
    min_acousticness: 0.0,
    max_acousticness: 0.4,
    min_danceability: 0.6,
    max_danceability: 1.0,
    min_energy: 0.7,
    max_energy: 1.0,
    min_instrumentalness: 0.0,
    max_instrumentalness: 1.0,
    min_tempo: 120,
    max_tempo: 300,
    min_valence: 0.0,
    max_valence: 1.0,
    time: 1,
    user:
  )

  Event.create!(
    title: 'Sleep',
    min_acousticness: 0.1,
    max_acousticness: 0.9,
    min_danceability: 0.0,
    max_danceability: 0.5,
    min_energy: 0.0,
    max_energy: 0.2,
    min_instrumentalness: 0.0,
    max_instrumentalness: 1.0,
    min_tempo: 80,
    max_tempo: 180,
    min_valence: 0.0,
    max_valence: 1.0,
    time: 2,
    user:
  )
end

Playlist.create!

playlist1 = Playlist.create!(title: 'watering flowers', user: user1, is_shared: true)

filepath = '/Users/shona/code/weepotty/soundstate/db/songs.csv'

CSV.foreach(filepath, headers: :first_row) do |row|
  Song.create!(spotify_id: row['spotify_id'], name: row['name'], uri: row['uri'], artist: row['artist'], acousticness: row['acousticness'], danceability: row['danceability'], energy: row['energy'], instrumentalness: row['instrumentalness'], tempo: row['tempo'], valence: row['valence'])
end

playlist1 = Playlist.create!(title:'watering plants', user: user1, is_shared: true)
playlist2 = Playlist.create!(title: 'George & Indiana', user: user2)
playlist3 = Playlist.create!(title: 'Stretching', user: user3, is_shared: true)
playlist4 = Playlist.create!(title: 'SHUIJIAO', user: user4, is_shared: true)
playlist5 = Playlist.create!(title: 'secret yoga', user: user5, is_shared: true)

# Song.all.sample(50).each do |song|
#   PlaylistsSong.create!(playlist: playlist1, song:)
#   SongsUser.create!(song:, user: user1)
# end
# Song.all.sample(50).each do |song|
#   PlaylistsSong.create!(playlist: playlist1, song:)
#   SongsUser.create!(song:, user: user1)
# end
# Song.all.sample(50).each do |song|
#   PlaylistsSong.create!(playlist: playlist1, song:)
#   SongsUser.create!(song:, user: user1)
# end
# Song.all.sample(50).each do |song|
#   PlaylistsSong.create!(playlist: playlist1, song:)
#   SongsUser.create!(song:, user: user1)
# end



# Playlist.create!(title: 'SHUI JIAO', spotify_id: '1BUSEFH8QA7cpuq8x5NUkF', user: user1, is_shared: true)
# Playlist.create!(title: '12/03/22', spotify_id: '39h6GUFlCwuIjIL9SNhgGn', user: user1)
# Playlist.create!(title: 'Warm up', spotify_id: '3Zi3WP45w3w3sMCSye5tqD', user: user1, is_shared: true)
# Playlist.create!(title: '2020', spotify_id: '7djWk93hoTVGMIoP3WQHmM', user: user1)
# Playlist.create!(title: '2019.04.18', spotify_id: '2iqNnWem8Uy2fs5zqj8YNZ', user: user1, is_shared: true)
# Playlist.create!(title: 'Jazz bossanova and stuff', spotify_id: '2HIgZySlv8HR4gE3kY1x5B', user: user1, is_shared: true)

# Playlist.create!(title: 'millenials', spotify_id: '6JoAVBBqi5JmdnmWELRnJa', user: user2)
# Playlist.create!(title: 'chill but no chill', spotify_id: '6dRv9kj05Ylq5XlAtpqrjs', user: user2)
# Playlist.create!(title: 'i love edm', spotify_id: '23I0EHbnpWbhchGbd5WBIp', user: user2, is_shared: true)
# Playlist.create!(title: 'boss', spotify_id: '0nLC6GaJCjejdoDqscLT1M', user: user2)
# Playlist.create!(title: 'secret yoga', spotify_id: '2sDakL9bYMnDT4ieERyIBD', user: user2)

# Playlist.create!(title: 'Temporary', spotify_id: '6OgDAJp86TNVuFqt3vi4cL', user: user3, is_shared: true)
# Playlist.create!(title: 'Baguette', spotify_id: '45JEE6q0iDO0Y6QDottVTj', user: user3)
# Playlist.create!(title: 'Boss WORKOUUUTT', spotify_id: '2WHJK2Q007wOOnfQCJZ7nM', user: user3)
# Playlist.create!(title: 'song', spotify_id: '5zhaSMGjMFq8PiIPgb8Ham', user: user3, is_shared: true)
# Playlist.create!(title: 'stretching', spotify_id: '0mAeoOnm1vVOWRg1wy6AFT', user: user3, is_shared: true)

# Playlist.create!(title: 'for my friends', spotify_id: '1UCY5fAnCk6w590OuAWvFS', user: user4, is_shared: true)
# Playlist.create!(title: 'make myself calm', spotify_id: '7sht7porXURcSQPeYMbR7E', user: user4)
# Playlist.create!(title: 'hiking', spotify_id: '1QasLhQdvGsQW7Si6HLW2s', user: user4, is_shared: true)
# Playlist.create!(title: 'wonderful calm', spotify_id: '5r5GApHpvB3O6IUl3O9D8t', user: user4, is_shared: true)
# Playlist.create!(title: 'musical therapy', spotify_id: '1uRn1Xd3AeitXDO8xkdd0n', user: user4, is_shared: true)
# Playlist.create!(title: 'yoga yoga', spotify_id: '6id7SVOIFSbXHNrWrUL6Vn', user: user4, is_shared: true)

# Playlist.create!(title: 'code monkey', spotify_id: '0mWhUI9HdprDlrY2JGXN1o', user: user5, is_shared: true)
# Playlist.create!(title: 'silence and calm', spotify_id: '4pwTaUwO5HNwQA3OsPFEDP', user: user5, is_shared: true)
# Playlist.create!(title: 'cycling', spotify_id: '1UoGc2m2g3IbepT1YJpNvG', user: user5, is_shared: true)
# Playlist.create!(title: 'chilling', spotify_id: '6iXQpDitArksnLfprwx3OV', user: user5, is_shared: true)
# Playlist.create!(title: 'alpha waves', spotify_id: '7jfg6SX0LJYseu71JmZ4RK', user: user5, is_shared: true)
# Playlist.create!(title: 'BOOM', spotify_id: '4G48L9Cas3KLUvCGx7Q2aS', user: user5, is_shared: true)

# puts 'seeded like a lovely garden'
