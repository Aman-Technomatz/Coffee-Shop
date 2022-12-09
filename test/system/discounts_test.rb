require "application_system_test_case"

class DiscountsTest < ApplicationSystemTestCase
  setup do
    @discount = discounts(:one)
  end

  test "visiting the index" do
    visit discounts_url
    assert_selector "h1", text: "Discounts"
  end

  test "should create discount" do
    visit discounts_url
    click_on "New discount"

    fill_in "Base item", with: @discount.base_item_id
    fill_in "Base item quantity", with: @discount.base_item_quantity
    fill_in "Child item", with: @discount.child_item_id
    fill_in "Child item quantity", with: @discount.child_item_quantity
    fill_in "Discount percent", with: @discount.discount_percent
    click_on "Create Discount"

    assert_text "Discount was successfully created"
    click_on "Back"
  end

  test "should update Discount" do
    visit discount_url(@discount)
    click_on "Edit this discount", match: :first

    fill_in "Base item", with: @discount.base_item_id
    fill_in "Base item quantity", with: @discount.base_item_quantity
    fill_in "Child item", with: @discount.child_item_id
    fill_in "Child item quantity", with: @discount.child_item_quantity
    fill_in "Discount percent", with: @discount.discount_percent
    click_on "Update Discount"

    assert_text "Discount was successfully updated"
    click_on "Back"
  end

  test "should destroy Discount" do
    visit discount_url(@discount)
    click_on "Destroy this discount", match: :first

    assert_text "Discount was successfully destroyed"
  end
end
