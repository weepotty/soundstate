class PlaylistsController < ApplicationController
  def index
    @playlists = Playlist.all
    # Eager loading for when we start on image generation
    # @playlists = Playlist.includes(:image).all
  end

  def show
    # @user = User.spotify_user
    # # show requires an "id" variable to insert into embeded iframe
    # @playlist = Playlist.includes(:spotify_id).find(params[:id])
  end

  def new
    # @user = User.spotify_user
    # @playlist = @user.create_playlist!('Best PLaylist Ever')
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
