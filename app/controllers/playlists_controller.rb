class PlaylistsController < ApplicationController
  def index
    @playlists = Playlist.all
    # Eager loading for when we start on image generation
    # @playlists = Playlist.includes(:image).all
  end

  def show
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
