class PagesController < ApplicationController
  def home
    if user_signed_in?
      render 'pages/home'
    else
      render 'pages/landing'
    end
  end

  def load_songs_page
  end

  def load_songs
    # get all the songs from user's library and their properties, and load into songs table
    ::ImportSongsService.call(
      spotify_user: current_user.spotify_user,
      current_user: current_user
    )

    # Sync user's playlists with Spotify as a background job.
    UpdatePlaylistsJob.perform_later(current_user)
    
    if current_user.songs.count < 200
      ::ImportSongRecommendationsJob.perform_later(current_user:)
    end

    redirect_to root_path
  end
end
