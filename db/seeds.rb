# Need to seed the Song model from a CSV file
require 'csv'

puts "Destroying data..."
PlaylistsSong.destroy_all
SongsUser.destroy_all
Song.destroy_all
Event.destroy_all
Playlist.destroy_all
User.destroy_all

puts 'Start planting new seeds'

puts 'Planting new users...'
user1 = User.create!(email: 'frank@frankdev.com', password: '123456', nickname: 'frank')
user1_avatar = URI.open("https://res.cloudinary.com/dsx50recn/image/upload/c_fill,h_256,w_256/v1679927913/Avatars/avatar_frank_x9drlt.jpg")
user1.avatar.attach(io: user1_avatar, filename: "avatar_frank_x9drlt.jpg", content_type: "image/jpg")
user1.save

user2 = User.create!(email: 'sally@sallydev.com', password: '123456', nickname: 'sally')
user2_avatar = URI.open("https://res.cloudinary.com/dsx50recn/image/upload/c_fill,h_256,w_256/v1679928346/Avatars/avatar_sally_zmdjkx.jpg")
user2.avatar.attach(io: user2_avatar, filename: "avatar_sally_zmdjkx.jpg", content_type: "image/jpg")
user2.save

user3 = User.create!(email: 'bob@bobdev.com', password: '123456', nickname: 'bob')
user3_avatar = URI.open("https://res.cloudinary.com/dsx50recn/image/upload/c_fill,h_256,w_256/v1679927913/Avatars/avatar_bob_p66uns.jpg")
user3.avatar.attach(io: user3_avatar, filename: "avatar_bob_p66uns.jpg", content_type: "image/jpg")
user3.save

user4 = User.create!(email: 'carol@caroldev.com', password: '123456', nickname: 'carol')
user4_avatar = URI.open("https://res.cloudinary.com/dsx50recn/image/upload/c_fill,h_256,w_256/v1679927913/Avatars/avatar_carol_g4zrkf.jpg")
user4.avatar.attach(io: user4_avatar, filename: "avatar_carol_g4zrkf.jpg", content_type: "image/jpg")
user4.save

user5 = User.create!(email: 'alice@alicedev.com', password: '123456', nickname: 'alice')
user5_avatar = URI.open("https://res.cloudinary.com/dsx50recn/image/upload/c_fill,h_256,w_256/v1679927913/Avatars/avatar_alice_indrsx.jpg")
user5.avatar.attach(io: user5_avatar, filename: "avatar_alice_indrsx.jpg", content_type: "image/jpg")
user5.save

users = [user1, user2, user3, user4, user5]

puts 'Planting new songs...'
filepath = 'db/songs.csv'

CSV.foreach(filepath, headers: :first_row) do |row|
  Song.create!(spotify_id: row['spotify_id'], name: row['name'], uri: row['uri'], artist: row['artist'], acousticness: row['acousticness'], danceability: row['danceability'], energy: row['energy'], tempo: row['tempo'], valence: row['valence'])
end

puts 'Planting new events...'
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

  SongsUser.create!(song: Song.first, user:)
end


puts 'Planting new playlists...'

playlist1_image = URI.open("https://res.cloudinary.com/drftmp0s5/image/upload/c_fill,h_256,w_256/v1679621030/millenial.png")
playlist1 = Playlist.create!(title: 'Stretching', user: user1, spotify_id: "0mAeoOnm1vVOWRg1wy6AFT", is_shared: true)
playlist1.photo.attach(io: playlist1_image, filename: "millenial.png", content_type: "image/png")
playlist1.save
PlaylistsSong.create!(playlist: playlist1, song: Song.first)

playlist2_image = URI.open("https://res.cloudinary.com/drftmp0s5/image/upload/c_fill,h_256,w_256/v1679624157/splitscreen_f3g6aj.png")
playlist2 = Playlist.create!(title: 'Code Monkey', user: user1, spotify_id: "0mWhUI9HdprDlrY2JGXN1o", is_shared: true)
playlist2.photo.attach(io: playlist2_image, filename: "splitscreen_f3g6aj.png", content_type: "image/png")
playlist2.save
PlaylistsSong.create!(playlist: playlist2, song: Song.first)

playlist3_image = URI.open("https://res.cloudinary.com/drftmp0s5/image/upload/c_fill,h_256,w_256/v1679624123/calm_hghfse.png")
playlist3 = Playlist.create!(title: 'Silence and Calm', user: user1, spotify_id: "4pwTaUwO5HNwQA3OsPFEDP", is_shared: true)
playlist3.photo.attach(io: playlist3_image, filename: "calm_hghfse.png", content_type: "image/png")
playlist3.save
PlaylistsSong.create!(playlist: playlist3, song: Song.first)

playlist4_image = URI.open("https://res.cloudinary.com/drftmp0s5/image/upload/c_fill,h_256,w_256/v1679624152/cubism_ggdch9.png")
playlist4 = Playlist.create!(title: 'Cycling', user: user1, spotify_id: "1UoGc2m2g3IbepT1YJpNvG", is_shared: true)
playlist4.photo.attach(io: playlist4_image, filename: "cubism_ggdch9.png", content_type: "image/png")
playlist4.save
PlaylistsSong.create!(playlist: playlist4, song: Song.first)

playlist5_image = URI.open("https://res.cloudinary.com/drftmp0s5/image/upload/c_fill,h_256,w_256/v1679621049/dreamybubbles.png")
playlist5 = Playlist.create!(title: 'Chilling', user: user1, spotify_id: "6iXQpDitArksnLfprwx3OV", is_shared: true)
playlist5.photo.attach(io: playlist5_image, filename: "dreamybubbles.png", content_type: "image/png")
playlist5.save
PlaylistsSong.create!(playlist: playlist5, song: Song.first)

playlist6_image = URI.open("https://res.cloudinary.com/drftmp0s5/image/upload/c_fill,h_256,w_256/v1679624161/tokyobag_qmcuga.png")
playlist6 = Playlist.create!(title: 'Exercise', user: user1, spotify_id: "501cNzLT6BHAc2BbjT7Vql", is_shared: true)
playlist6.photo.attach(io: playlist6_image, filename: "tokyobag_qmcuga.png", content_type: "image/png")
playlist6.save
PlaylistsSong.create!(playlist: playlist6, song: Song.first)

playlist7_image = URI.open("https://res.cloudinary.com/drftmp0s5/image/upload/c_fill,h_256,w_256/v1679624160/stretching_nnw5qt.png")
playlist7 = Playlist.create!(title: 'Yoga', user: user2, spotify_id: "2sDakL9bYMnDT4ieERyIBD", is_shared: true)
playlist7.photo.attach(io: playlist7_image, filename: "stretching_nnw5qt.png", content_type: "image/png")
playlist7.save
PlaylistsSong.create!(playlist: playlist7, song: Song.first)

playlist8_image = URI.open("https://res.cloudinary.com/drftmp0s5/image/upload/c_fill,h_256,w_256/v1679624157/milkyway_cebdhg.png")
playlist8 = Playlist.create!(title: 'In The Zone', user: user2, spotify_id: "7jfg6SX0LJYseu71JmZ4RK", is_shared: true)
playlist8.photo.attach(io: playlist8_image, filename: "milkyway_cebdhg.png", content_type: "image/png")
playlist8.save
PlaylistsSong.create!(playlist: playlist8, song: Song.first)

playlist9_image = URI.open("https://res.cloudinary.com/drftmp0s5/image/upload/c_fill,h_256,w_256/v1679621024/botanicalart.png")
playlist9 = Playlist.create!(title: 'Coffee House', user: user3, spotify_id: "4U42sfz3cWz3T8CtOmyWz2", is_shared: true)
playlist9.photo.attach(io: playlist9_image, filename: "botanicalart.png", content_type: "image/png")
playlist9.save
PlaylistsSong.create!(playlist: playlist9, song: Song.first)

puts 'Seeded like a lovely garden'
