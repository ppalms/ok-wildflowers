require "application_system_test_case"

class LocationsTest < ApplicationSystemTestCase
  setup do
    @location = locations(:front)
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
    click_on "Back"
  end

  test "should update Location" do
    visit location_url(@location)
    click_on "Edit", match: :first

    fill_in "Name", with: @location.name
    click_on "Update Location"

    # assert_text "Location was successfully updated"
    click_on "Back"
  end

  test "should delete Location" do
    visit location_url(@location)
    click_on "Delete this location", match: :first

    accept_confirm

    assert_text "Location was successfully deleted"
  end
end
