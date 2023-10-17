class EventsController < ApplicationController
  before_action :set_event, only: %i[ show edit update destroy organization ]

  # GET /events or /events.json
  def index
    if params[:search].present?
      @events = Event.order(:date_scheduled).where("name LIKE ?", "%#{params[:search]}%").paginate(page: params[:page])
    else
      @events = Event.order(:date_scheduled).paginate(page: params[:page])
    end
  end

  # GET /events/1 or /events/1.json
  def show
  end

  # GET /events/new
  def new
    @event = Event.new
    @tracks = Array.new
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events or /events.json
  def create
    @event = Event.new(event_params)
    @tracks = JSON.parse(params[:tracks])
    

    respond_to do |format|
      if @event.save
        @tracks.each do |track|
          @new_track = Track.new(title: track['title'])
          @new_track.event = @event
          if  @new_track.save          
          track['lectures'].each do |lecture|
            @lecture = Lecture.new(time_duration: lecture['time_duration'], time_scheduled: lecture['time_scheduled'],  title: lecture['title'])
            @lecture.track = @new_track
            @lecture.save
          end
        end
        end
        @events = Event.order(:date_scheduled).paginate(page: params[:page])
        format.turbo_stream { render turbo_stream: turbo_stream.replace("events", partial: "events", locals: { events: @events, notice: "Event was successfully created." }) }
        format.html { redirect_to events_path, notice: "Event was successfully created." }
        format.json { render :show, status: :created, location: @event }
      else
        @tracks = @tracks.to_json
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end
  def organization
  end
  
  # PATCH/PUT /events/1 or /events/1.json
  def update
    @tracks = JSON.parse(params[:tracks])
    respond_to do |format|
      if @event.update(event_params)
        @event.tracks.each do |track| 
          track.lectures.each do |lecture| 
            Lecture.where(:tracks_id => track.id).delete_all()
          end 
        end 
        Track.where(:events_id => @event.id).delete_all()
        @tracks.each do |track|
          @new_track = Track.new(title: track['title'])
          @new_track.event = @event
          if  @new_track.save          
          track['lectures'].each do |lecture|
            @lecture = Lecture.new(time_duration: lecture['time_duration'], time_scheduled: lecture['time_scheduled'],  title: lecture['title'])
            @lecture.track = @new_track
            @lecture.save
          end
        end
        end
        format.turbo_stream { render turbo_stream: turbo_stream.replace(@event, partial: "event", locals: { event: @event }) }
        format.html { redirect_to event_url(@event), notice: "Event was successfully updated." }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end


  # DELETE /events/1 or /events/1.json
  def destroy
    @event.destroy

    respond_to do |format|
      format.html { redirect_to events_url, notice: "Event was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_event
    @event = Event.find(params[:id])
    @tracks = @event.tracks.as_json(:include =>:lectures).to_json
  end

  # Only allow a list of trusted parameters through.
  def event_params
    params.require(:event).permit(:name, :date_scheduled)
  end
  def event_tracks
    params.require(:tracks).permit(:name, :date_scheduled, :lectures)
  end
end
