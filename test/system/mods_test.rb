require "application_system_test_case"

class ModsTest < ApplicationSystemTestCase
  setup do
    @mod = mods(:one)
  end

  test "visiting the index" do
    visit mods_url
    assert_selector "h1", text: "Mods"
  end

  test "should create mod" do
    visit mods_url
    click_on "New mod"

    fill_in "Name", with: @mod.name
    click_on "Create Mod"

    assert_text "Mod was successfully created"
    click_on "Back"
  end

  test "should update Mod" do
    visit mod_url(@mod)
    click_on "Edit this mod", match: :first

    fill_in "Name", with: @mod.name
    click_on "Update Mod"

    assert_text "Mod was successfully updated"
    click_on "Back"
  end

  test "should destroy Mod" do
    visit mod_url(@mod)
    click_on "Destroy this mod", match: :first

    assert_text "Mod was successfully destroyed"
  end
end
