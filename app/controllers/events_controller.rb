class EventsController < ApplicationController
  # GET /events/new
  def new
    @event = Event.new
    @events = current_user.events

    respond_to do |format|
      format.html
      format.json
    end
  end

  # POST /events
  def create
    @event = Event.new(event_params)
    @event.user = current_user
    if @event.save
      redirect_to new_event_playlist_path(@event)
    else
      @events = current_user.events
      scale_down_tempo(@event)
      render :new, status: :unprocessable_entity
    end
  end

  def image
    @event = Event.find(params[:event_id])
    @songs = @event.filter_songs(current_user).first

    # get the url of generated image
    @ai_image_url = ::GenerateImageService.call(
      song: @songs.sample,
      event: @event
    )

    respond_to do |format|
      format.text { render plain: @ai_image_url }
    end
  end

  # GET /events/:id/edit
  def edit
    @event = Event.find(params[:id])
    @events = current_user.events

    # 220 tempo for the maximum range, to fit slider of 0 to 1
    scale_down_tempo(@event)

    respond_to do |format|
      format.html
      format.json
    end
  end

  # PATCH /events/:id
  def update
    @event = Event.find(params[:id])
    if @event.update(event_params)
      redirect_to new_event_playlist_path(@event)
    else
      @events = current_user.events
      scale_down_tempo(@event)
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def event_params
    params[:event][:time] = params[:event][:time].to_i
    # Convert the slider value of the tempo back to 0-220 range, as table is storing in 0-220 range.
    params[:event][:min_tempo] = params[:event][:min_tempo].to_f * 220
    params[:event][:max_tempo] = params[:event][:max_tempo].to_f * 220
    params.require(:event).permit(:title,
                                  :min_acousticness, :max_acousticness,
                                  :min_danceability, :max_danceability,
                                  :min_energy, :max_energy,
                                  :min_tempo, :max_tempo,
                                  :min_valence, :max_valence,
                                  :time
                                )
  end

  # Method to scale down the tempo from 0-220 range to 0-1 range.
  def scale_down_tempo(event)
    event.min_tempo = (event.min_tempo / 220)
    event.max_tempo = (event.max_tempo / 220)
  end
end
