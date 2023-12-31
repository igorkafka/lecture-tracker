class LecturesController < ApplicationController
  before_action :set_lecture, only: %i[ show edit update destroy ]

  # GET /lectures or /lectures.json
  def index
    @lectures = Lecture.all
  end

  # GET /lectures/1 or /lectures/1.json
  def show
  end

  # GET /lectures/new
  def new
    @lecture = Lecture.new
  end

  # GET /lectures/1/edit
  def edit
  end

  # POST /lectures or /lectures.json
  def create
    @lecture = Lecture.new(lecture_params)

    respond_to do |format|
      if @lecture.save
        format.html { redirect_to lecture_url(@lecture), notice: "Lecture was successfully created." }
        format.json { render :show, status: :created, location: @lecture }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @lecture.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lectures/1 or /lectures/1.json
  def update
    respond_to do |format|
      if @lecture.update(lecture_params)
        format.html { redirect_to lecture_url(@lecture), notice: "Lecture was successfully updated." }
        format.json { render :show, status: :ok, location: @lecture }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @lecture.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lectures/1 or /lectures/1.json
  def destroy
    @lecture.destroy

    respond_to do |format|
      format.html { redirect_to lectures_url, notice: "Lecture was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def file 
    file_data = params[:lecture_file]

    if file_data.respond_to?(:read)
      @lines = file_data.read.force_encoding('UTF-8')
    elsif file_data.respond_to?(:path,  encoding: 'UTF-8')
      @lines = File.read(file_data.path)
    else
      logger.error "Bad file_data: #{@file_data.class.name}: #    
                {@filename.inspect}"
    end
    begin
      formatted_lectures = Lecture.parse_lectures(@lines.split(/\r\n/))
      tracks = Track.build_tracks(formatted_lectures)
      render :json => tracks.as_json(:include =>:lectures)
    rescue => e
      render :json => "#{e.message}"
    end
  end
  

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_lecture
    @lecture = Lecture.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def lecture_params
    params.require(:lecture).permit(:title, :event_id)
  end
end
