require "application_system_test_case"

class LocationsTest < ApplicationSystemTestCase
  setup do
    login_as users(:gardener)
    @location = locations(:front_yard)
  end

  test "visiting the index" do
    visit locations_url
    assert_selector "h1", text: "Locations"
  end

  test "should create location" do
    visit locations_url
    click_on "New location"

    fill_in "Name", with: @location.name
    click_on "Create Location"

    assert_text "Location was successfully created"
  end

  test "should update location" do
    visit location_url(@location)
    click_on "Edit", match: :first

    fill_in "Name", with: "New Location Name"
    click_on "Update Location"

    assert_text "New Location Name"
  end

  test "should add plant to location" do
    visit location_url(@location)
    click_on "Add Plants"

    assert_selector :css, "#search_plants", visible: true

    plant = plants(:indian_paintbrush)

    button_wrapper = find("#plant_#{plant.id}_add_button")
    within(button_wrapper) do
      page.execute_script("arguments[0].click();", find('input[type="submit"]'))
    end

    assert_text "Added"

    click_button "×"
    assert_selector :css, "#search_plants", visible: false

    assert_text plant.common_name
    assert @location.plants.include?(plant)
  end

  test "should remove plant from location" do
    visit location_url(@location)

    plant = plants(:indian_paintbrush)
    @location.plants << plant

    visit location_url(@location)

    button_wrapper = find("#remove_plant_#{plant.id}")
    within(button_wrapper) do
      click_button "Remove"
    end

    accept_confirm

    assert_no_text plant.common_name
    assert_not @location.plants.include?(plant)
  end

  test "should add note to location" do
    visit location_url(@location)
    click_on "Add Note", match: :first

    fill_in "note_content", with: "This is a new note"
    click_on "Create Note"

    assert_text "Note was successfully created"
    assert_text "This is a new note"
  end

  test "should not save blank note to location" do
    visit location_url(@location)
    click_on "Add Note", match: :first

    fill_in "note_content", with: ""
    click_on "Create Note"

    assert_text "Content can't be blank"

    click_on "Back"
    click_on "This is a note", match: :first

    click_on "Edit", match: :first

    fill_in "note_content", with: ""
    click_on "Update Note"

    assert_text "Content can't be blank"
  end

  test "should edit note" do
    visit location_url(@location)
    click_on "This is a note", match: :first

    click_on "Edit", match: :first

    fill_in "note_content", with: "This is an edited note"
    click_on "Update Note"

    assert_text "Note was successfully updated"
    assert_text "This is an edited note"
  end

  test "should delete note" do
    visit location_url(@location)
    note = notes(:one)

    click_on note.content, match: :first

    assert_text note.created_at.strftime("%m/%d/%Y")

    click_on "Delete", match: :first

    accept_confirm

    assert_text "Note was successfully deleted"
  end

  test "should delete location" do
    visit location_url(@location)
    click_on "Delete this location", match: :first

    accept_confirm

    assert_text "Location was successfully deleted"
  end
end
