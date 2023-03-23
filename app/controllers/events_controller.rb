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
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  # GET /events/:id/edit
  def edit
    @event = Event.find(params[:id])
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
