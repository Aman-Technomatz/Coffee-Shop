require "application_system_test_case"

class TaxCategoriesTest < ApplicationSystemTestCase
  setup do
    @tax_category = tax_categories(:one)
  end

  test "visiting the index" do
    visit tax_categories_url
    assert_selector "h1", text: "Tax categories"
  end

  test "should create tax category" do
    visit tax_categories_url
    click_on "New tax category"

    fill_in "Tax rate", with: @tax_category.tax_rate
    click_on "Create Tax category"

    assert_text "Tax category was successfully created"
    click_on "Back"
  end

  test "should update Tax category" do
    visit tax_category_url(@tax_category)
    click_on "Edit this tax category", match: :first

    fill_in "Tax rate", with: @tax_category.tax_rate
    click_on "Update Tax category"

    assert_text "Tax category was successfully updated"
    click_on "Back"
  end

  test "should destroy Tax category" do
    visit tax_category_url(@tax_category)
    click_on "Destroy this tax category", match: :first

    assert_text "Tax category was successfully destroyed"
  end
end
