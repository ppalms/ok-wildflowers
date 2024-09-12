class NotesController < ApplicationController
  before_action :set_location
  before_action :set_note, only: [:show, :edit, :update, :destroy]

  def new
    @note = @location.notes.build
    render 'locations/notes/new'
  end

  def create
    @note = @location.notes.build(note_params)
    if @note.save
      redirect_to @location, notice: 'Note was successfully created.'
    else
      render 'locations/notes/new', status: :unprocessable_entity
    end
  end

  def edit
    render 'locations/notes/edit'
  end

  def update
    if @note.update(note_params)
      redirect_to @location, notice: 'Note was successfully updated.'
    else
      render 'locations/notes/edit', status: :unprocessable_entity
    end
  end

  def show
    render 'locations/notes/show'
  end

  def destroy
    @note.destroy
    redirect_to @location, notice: 'Note was successfully deleted.'
  end

  private

  def set_location
    @location = Location.find(params[:location_id])
  end

  def set_note
    @note = @location.notes.find(params[:id])
  end

  def note_params
    params.require(:note).permit(:content)
  end
end
