require "application_system_test_case"

class NotesTest < ApplicationSystemTestCase
  setup do
    login_as users(:gardener)
    @location = locations(:front_yard)
  end

  test "should add note to location" do
    visit location_url(@location)
    click_tab "Notes"
    click_on "Add Note"

    fill_in "note_content", with: "This is a new note"
    click_on "Create Note"

    click_tab "Notes"
    assert_text "Note was successfully created"
    assert_text "This is a new note"
  end

  test "should not save blank note to location" do
    visit location_url(@location)
    click_tab "Notes"
    click_on "Add Note"

    fill_in "note_content", with: ""
    click_on "Create Note"

    assert_text "Content can't be blank"

    click_on "Back"
    click_tab "Notes"
    click_on "This is a note"

    assert_text "Edit"
    click_on "Edit"
    assert_text "Editing note"

    fill_in "note_content", with: ""
    click_on "Update Note"

    assert_text "Content can't be blank"
  end

  test "should edit note" do
    visit location_url(@location)
    click_tab "Notes"
    note = notes(:one)

    click_on note.content

    assert_text note.created_at.strftime("%m/%d/%Y")

    click_on "Edit"
    fill_in "note_content", with: "This is an edited note"
    click_on "Update Note"

    click_tab "Notes"
    assert_text "Note was successfully updated"
    assert_text "This is an edited note"
  end

  test "should delete note" do
    visit location_url(@location)
    click_tab "Notes"
    note = notes(:one)

    click_on note.content

    assert_text note.created_at.strftime("%m/%d/%Y")

    click_on "Delete"

    accept_confirm

    assert_text "Note was successfully deleted"
  end
end
