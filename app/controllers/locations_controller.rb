class LocationsController < ApplicationController
  before_action :set_location, only: [:show, :edit, :update, :destroy,:get_share_location, :post_share_location]

  # GET /locations
  # GET /locations.json
  def index
    @locations = current_user.locations.all
  end

  # GET /locations/1
  # GET /locations/1.json
  def show
  end

  # GET /locations/new
  def new
    @location = current_user.locations.new
  end

  # GET /locations/1/edit
  def edit
  end

  # POST /locations
  # POST /locations.json
  def create
    @location = current_user.locations.new(location_params)
    respond_to do |format|
      if @location.save
        format.html { redirect_to @location, notice: 'Location was successfully created.' }
        format.json { render :show, status: :created, location: @location }
      else
        format.html { render :new }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /locations/1
  # PATCH/PUT /locations/1.json
  def update
    respond_to do |format|
      if @location.update(location_params)
        format.html { redirect_to @location, notice: 'Location was successfully updated.' }
        format.json { render :show, status: :ok, location: @location }
      else
        format.html { render :edit }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /locations/1
  # DELETE /locations/1.json
  def destroy
    @location.destroy
    respond_to do |format|
      format.html { redirect_to locations_url, notice: 'Location was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  def get_share_location
  end

  def post_share_location
    shared_user_ids = params["shared_with"].reject(&:empty?)
    if shared_user_ids.empty?
      current_user.shared_locations.create(location: @location)
    else
      shared_user_ids.each do |id|
        current_user.shared_locations.create!(location: @location, shared_with_id: id, private: false)
      end
    end
    flash[:success] = 'You have shared location successfully'
    redirect_to root_path
  end

  def loginin_users
    @logged_in_users = LoggedinUser.all
  end

  def shared_locations
    @share_location = current_user.shared
  end

  def shared_with_location
    @shared_with_me = current_user.shared_with
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_location
    @location = current_user.locations.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def location_params
    params.require(:location).permit(:address)
  end
end
