class PlantsController < ApplicationController
  before_action :set_plant, only: %i[ show edit update destroy ]

  # GET /plants or /plants.json
  def index
    @plants = current_organization.plants.order(:common_name)
    @plants = @plants.where("common_name ILIKE ?", "%#{params[:name]}%").or(@plants.where("scientific_name ILIKE ?", "%#{params[:name]}%")) if params[:name].present?
    @plants = @plants.joins(:bloom_colors).where(bloom_colors: { id: params[:bloom_colors].split(",") }).distinct if params[:bloom_colors].present?
  end

  # GET /plants/1 or /plants/1.json
  def show
  end

  # GET /plants/new
  def new
    @plant = Plant.new
  end

  # GET /plants/1/edit
  def edit
  end

  # POST /plants or /plants.json
  def create
    @plant = current_organization.plants.build(plant_params)

    respond_to do |format|
      if @plant.save
        format.html { redirect_to plant_url(@plant), notice: "Plant was successfully created." }
        format.json { render :show, status: :created, location: @plant }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @plant.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /plants/1 or /plants/1.json
  def update
    respond_to do |format|
      if @plant.update(plant_params)
        format.html { redirect_to plant_url(@plant), notice: "Plant was successfully updated." }
        format.json { render :show, status: :ok, location: @plant }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @plant.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /plants/1 or /plants/1.json
  def destroy
    @plant.destroy!

    respond_to do |format|
      format.html { redirect_to plants_url, notice: "Plant was successfully deleted." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_plant
      @plant = current_organization.plants.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def plant_params
      params.require(:plant).permit(:scientific_name, :common_name, :other_common_names_list, :photo, bloom_color_ids: [], bloom_month_ids: [])
    end
end
