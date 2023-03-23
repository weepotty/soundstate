class EventsController < ApplicationController
  # GET /events/new
  def new
    @event = Event.new
  end
  
  # POST /events
  def create
    @event = Event.new(event_params)
    @event.user = current_user
    if @event.save
      redirect_to new_event_playlist_path(@event)
    else
      render :new, status: :unprocessable_entity
    end
  end

  # GET /events/:id/edit
  def edit
    @event = Event.find(params[:id])
    # 220 tempo for the maximum range, to fit slider of 0 to 1
    @event.min_tempo = (@event.min_tempo / 220)
    @event.max_tempo = (@event.max_tempo / 220)
  end

  # PATCH /events/:id
  def update
    @event = Event.find(params[:id])
    if @event.update(event_params)
      redirect_to root_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def event_params
    params[:event][:time] = params[:event][:time].to_i
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
end
