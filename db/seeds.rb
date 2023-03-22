# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or create!d alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create!([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create!(name: "Luke", movie: movies.first)

puts "destroying data..."
PlaylistsSong.destroy_all
SongsUser.destroy_all
Playlist.destroy_all
Event.destroy_all
User.destroy_all

# puts 'planting new seeds'

# user1 = User.create!(email: 'frank@frankdev.com', password: '123456', nickname: 'frank')
# user2 = User.create!(email: 'sally@sallydev.com', password: '123456', nickname: 'sally')
# user3 = User.create!(email: 'bob@bobdev.com', password: '123456', nickname: 'bob')
# user4 = User.create!(email: 'carol@caroldev.com', password: '123456', nickname: 'carol')
# user5 = User.create!(email: 'alice@alicedev.com', password: '123456', nickname: 'alice')

# users = [user1, user2, user3, user4, user5]

# users.each do |user|
#   Event.create!(
#     title: 'Getting ready',
#     acousticness: 0.5,
#     danceability: 0.2,
#     energy: 0.8,
#     instrumentalness: 0.5,
#     tempo: 120,
#     valence: 0.8,
#     time: 0,
#     user:
#   )

#   Event.create!(
#     title: 'Commuting',
#     acousticness: 0.002,
#     danceability: 0.5,
#     energy: 0.8,
#     instrumentalness: 0.01,
#     tempo: 150,
#     valence: 0.1,
#     time: 0,
#     user:
#   )

#   Event.create!(
#     title: 'Focusing',
#     acousticness: 0.01,
#     danceability: 0.01,
#     energy: 0.01,
#     instrumentalness: 0.8,
#     tempo: 100,
#     valence: 0.5,
#     time: 1,
#     user:
#   )

#   Event.create!(
#     title: 'Exercising',
#     acousticness: 0.001,
#     danceability: 0.9,
#     energy: 0.9,
#     instrumentalness: 0.01,
#     tempo: 180,
#     valence: 0.9,
#     time: 1,
#     user:
#   )

#   Event.create!(
#     title: 'Sleep',
#     acousticness: 0.99,
#     danceability: 0.001,
#     energy: 0.001,
#     instrumentalness: 0.99,
#     tempo: 80,
#     valence: 0.2,
#     time: 2,
#     user:
#   )
# end
# Playlist.create!(title: 'watering flowers', spotify_id: ' 5QdNcyHWRMbk4pVkNyZ3KV', user: user1, is_shared: true)
# Playlist.create!(title: 'George & Indiana', spotify_id: '1gzG3ZRfALERu7FPMVnqbh', user: user1)
# Playlist.create!(title: 'Stretching', spotify_id: '5KYSIizv3U4UviajZphukl', user: user1, is_shared: true)
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
