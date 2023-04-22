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
    if new_user?
      ::ImportSongsService.call(
        spotify_user: current_user.spotify_user,
        current_user: current_user
      )
    else
    end

    # Sync user's playlists with Spotify as a background job.
    UpdatePlaylistsJob.perform_later(current_user)

    redirect_to root_path
  end

  private

  def new_user?
    # User created within the last 60 seconds
    (Time.now - current_user.created_at) < 60
  end
end
