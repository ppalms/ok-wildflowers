class LocationsController < ApplicationController
  include LocationsHelper

  before_action :set_location, only: %i[show edit update destroy]
  before_action :set_plant_location, only: %i[list_plants search_plants add_plant remove_plant]

  # GET /locations or /locations.json
  def index
    @locations = tenant.locations
  end

  # GET /locations/1 or /locations/1.json
  def show
    @overview = location_overview(@location)
    @plants = @location.plants
  end

  # GET /locations/new
  def new
    @location = Location.new
  end

  # GET /locations/1/edit
  def edit; end

  # POST /locations or /locations.json
  def create
    @location = tenant.locations.build(location_params)

    respond_to do |format|
      if @location.save
        format.html { redirect_to location_url(@location), notice: "Location was successfully created." }
        format.json { render :show, status: :created, location: @location }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /locations/1 or /locations/1.json
  def update
    respond_to do |format|
      if @location.update(location_params)
        format.html { redirect_to location_url(@location), notice: "Location was successfully updated." }
        format.json { render :show, status: :ok, location: @location }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /locations/1 or /locations/1.json
  def destroy
    @location.destroy!

    respond_to do |format|
      format.html { redirect_to locations_url, notice: "Location was successfully deleted." }
      format.json { head :no_content }
    end
  end

  def list_plants
    @plants = @location.plants.order(:common_name)

    respond_to do |format|
      format.html { render "locations/plants/index" }
    end
  end

  # GET /locations/1/search_plants
  def search_plants
    @plants = tenant.plants.order(:common_name)
    @plants = @plants.where("common_name ILIKE ?", "%#{params[:name]}%").or(@plants.where("scientific_name ILIKE ?", "%#{params[:name]}%")) if params[:name].present?

    respond_to do |format|
      format.html { render "locations/plants/search_plants" }
    end
  end

  def add_plant
    plant = tenant.plants.find(params[:plant_id])
    @location.plants << plant unless @location.plants.include?(plant)

    respond_to do |format|
      format.turbo_stream do
        @overview = location_overview(@location)
        @plants = @location.plants
        render turbo_stream: [
          turbo_stream.replace("location_details", template: "locations/plants/index"),
          turbo_stream.replace("plant_#{plant.id}_add_button", partial: "locations/plants/added_plant", locals: { plant: })
        ]
      end
      format.html { redirect_to @location, notice: "#{plant.common_name} was successfully added." }
    end
  end

  def remove_plant
    plant = tenant.plants.find(params[:plant_id])
    @location.plants.delete(plant)

    respond_to do |format|
      format.turbo_stream do
        @overview = location_overview(@location)
        @plants = @location.plants
        render turbo_stream: [
          turbo_stream.replace("location_details", template: "locations/plants/index")
        ]
      end
      format.html { redirect_to @location, notice: 'Plant was successfully removed.' }
    end
  end

  private

  def set_location
    @location = tenant.locations.find(params[:id])
  end

  def set_plant_location
    @location = tenant.locations.find(params[:location_id])
  end

  def location_params
    params.require(:location).permit(:name)
  end
end
