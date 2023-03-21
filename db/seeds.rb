# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or create!d alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create!([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create!(name: "Luke", movie: movies.first)


puts "destroying data..."
Playlist.destroy_all
Event.destroy_all
User.destroy_all

puts 'planting new seeds'

User.create!(email: 'frank@frankdev.com', password: '123456', nickname: 'frank')
User.create!(email: 'sally@sallydev.com', password: '123456', nickname: 'sally')
User.create!(email: 'bob@bobdev.com', password: '123456', nickname: 'bob')
User.create!(email: 'carol@caroldev.com', password: '123456', nickname: 'carol')
User.create!(email: 'alice@alicedev.com', password: '123456', nickname: 'alice')

Event.create!(
  title: 'Getting ready',
  acousticness: 0.5,
  danceability: 0.2,
  energy: 0.8,
  instrumentalness: 0.5,
  tempo: 120,
  valence: 0.8
)

puts 'seeded like a lovely garden'
