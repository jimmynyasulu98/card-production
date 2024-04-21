require "application_system_test_case"

class CoversTest < ApplicationSystemTestCase
  setup do
    @cover = covers(:one)
  end

  test "visiting the index" do
    visit covers_url
    assert_selector "h1", text: "Covers"
  end

  test "should create cover" do
    visit covers_url
    click_on "New cover"

    fill_in "Name", with: @cover.name
    click_on "Create Cover"

    assert_text "Cover was successfully created"
    click_on "Back"
  end

  test "should update Cover" do
    visit cover_url(@cover)
    click_on "Edit this cover", match: :first

    fill_in "Name", with: @cover.name
    click_on "Update Cover"

    assert_text "Cover was successfully updated"
    click_on "Back"
  end

  test "should destroy Cover" do
    visit cover_url(@cover)
    click_on "Destroy this cover", match: :first

    assert_text "Cover was successfully destroyed"
  end
end
