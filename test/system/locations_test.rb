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

  test "should update Location" do
    visit location_url(@location)
    click_on "Edit", match: :first

    fill_in "Name", with: "New Location Name"
    click_on "Update Location"

    assert_text "New Location Name"
  end

  test "should add Note to Location" do
    visit location_url(@location)
    click_on "New Note", match: :first

    fill_in "note_content", with: "This is a note"
    click_on "Create Note"

    assert_text "Note was successfully created"
    assert_text "This is a note"
  end

  test "should not add blank Note to Location" do
    visit location_url(@location)
    click_on "New Note", match: :first

    fill_in "note_content", with: ""
    click_on "Create Note"

    assert_text "Content can't be blank"
  end

  test "should delete Location" do
    visit location_url(@location)
    click_on "Delete this location", match: :first

    accept_confirm

    assert_text "Location was successfully deleted"
  end
end
