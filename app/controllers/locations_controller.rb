class LocationsController < ApplicationController
  include LocationsHelper

  before_action :set_location, only: %i[show edit update destroy add_plant remove_plant]

  # GET /locations or /locations.json
  def index
    @locations = Location.all
  end

  # GET /locations/1 or /locations/1.json
  def show
    @overview = location_overview(@location)
    @plants = @location.plants
    @available_plants = Plant.where.not(id: @plants.pluck(:id))
  end

  # GET /locations/new
  def new
    @location = Location.new
  end

  # GET /locations/1/edit
  def edit; end

  # POST /locations or /locations.json
  def create
    @location = Location.new(location_params)

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
      format.html { redirect_to locations_url, notice: "Location was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def add_plant
    plant = Plant.find(params[:plant_id])
    @location.plants << plant unless @location.plants.include?(plant)

    respond_to do |format|
      format.turbo_stream do
        @overview = location_overview(@location)
        @plants = @location.plants
        @available_plants = Plant.where.not(id: @plants.pluck(:id))
        render turbo_stream: [
          turbo_stream.replace("overview", partial: "locations/overview", locals: { overview: @overview }),
          turbo_stream.replace("plant_list", partial: "locations/plant_list", locals: { plants: @plants }),
          turbo_stream.replace("plant_form", partial: "locations/plant_form", locals: { available_plants: @available_plants })
        ]
      end
      format.html { redirect_to @location, notice: 'Plant was successfully added.' }
    end
  end

  def remove_plant
    plant = Plant.find(params[:plant_id])
    @location.plants.delete(plant)

    respond_to do |format|
      format.turbo_stream do
        @overview = location_overview(@location)
        @plants = @location.plants
        @available_plants = Plant.where.not(id: @plants.pluck(:id))
        render turbo_stream: [
          turbo_stream.replace("overview", partial: "locations/overview", locals: { overview: @overview }),
          turbo_stream.replace("plant_list", partial: "locations/plant_list", locals: { plants: @plants }),
          turbo_stream.replace("plant_form", partial: "locations/plant_form", locals: { available_plants: @available_plants })
        ]
      end
      format.html { redirect_to @location, notice: 'Plant was successfully removed.' }
    end
  end

  private

  def set_location
    @location = Location.find(params[:id])
  end

  def location_params
    params.require(:location).permit(:name)
  end
end