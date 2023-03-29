require 'csv'

class UsersController < ApplicationController
  def spotify
    # create an RSpotify User
    spotify_user = RSpotify::User.new(request.env['omniauth.auth'])
    spotify_auth = spotify_user.to_hash
    @user = User.create_from_spotify(spotify_user, spotify_auth)

    if @user.persisted?
      # flash[:notice] = I18n.t 'devise.omniauth_callbacks.success', kind: 'Spotify'
      sign_in_and_redirect @user, event: :authentication
    else
      # Removing extra as it can overflow some session stores
      session['devise.spotify_data'] = request.env['omniauth.auth'].except('extra')
      redirect_to new_user_registration_url, alert: @user.errors.full_messages.join("\n")
    end
  end

  # GET /users/
  def index
    if params[:query]
      @query = params[:query]
      @users = User.search_by_nickname(@query)
    else
      @users = User.all
    end

    respond_to do |format|
      format.html # Follow regular flow of Rails
      format.text { render partial: 'shared/search_output', locals: {user: @users}, formats: [:html] }
    end
  end

  # GET /users/:id
  def show
    @user = User.find(params[:id])
    current_user
    @playlists = current_user.playlists
    @events = current_user.events
  end

  # GET /users/:id/edit
  def edit
    @user = current_user
  end

  # PATCH /users/:id
  def update
    @user = User.find(params[:id])
    @user.nickname = user_params[:nickname]
    if user_params[:avatar]
      @user.avatar = user_params[:avatar]
    end

    if @user.save
      redirect_to user_path(@user)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:nickname, :avatar)
  end
end
