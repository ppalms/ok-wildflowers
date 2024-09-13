require "application_system_test_case"

class PlantsTest < ApplicationSystemTestCase
  setup do
    login_as users(:gardener)
    @plant = plants(:indian_blanket)
  end

  test "visiting the index" do
    visit plants_url
    assert_selector "h1", text: "Plants"
  end

  test "should create plant" do
    visit plants_url
    click_on "New plant"

    fill_in "Common name", with: @plant.common_name
    fill_in "Scientific name", with: @plant.scientific_name
    click_on "Create Plant"

    assert_text "Plant was successfully created"
    click_on "Back"
  end

  test "should update Plant" do
    visit plant_url(@plant)
    click_on "Edit", match: :first

    fill_in "Scientific name", with: @plant.scientific_name
    click_on "Update Plant"

    assert_text "Plant was successfully updated"
    click_on "Back"
  end

  test "should delete Plant" do
    visit plant_url(@plant)
    click_on "Delete", match: :first

    accept_confirm

    assert_text "Plant was successfully deleted"
  end

  test "showing a plant" do
    visit plants_url
    click_link @plant.common_name

    assert_selector "h1", text: @plant.common_name
  end
end
