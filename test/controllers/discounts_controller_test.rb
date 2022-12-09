require "test_helper"

class DiscountsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @discount = discounts(:one)
  end

  test "should get index" do
    get discounts_url
    assert_response :success
  end

  test "should get new" do
    get new_discount_url
    assert_response :success
  end

  test "should create discount" do
    assert_difference("Discount.count") do
      post discounts_url, params: { discount: { base_item_id: @discount.base_item_id, base_item_quantity: @discount.base_item_quantity, child_item_id: @discount.child_item_id, child_item_quantity: @discount.child_item_quantity, discount_percent: @discount.discount_percent } }
    end

    assert_redirected_to discount_url(Discount.last)
  end

  test "should show discount" do
    get discount_url(@discount)
    assert_response :success
  end

  test "should get edit" do
    get edit_discount_url(@discount)
    assert_response :success
  end

  test "should update discount" do
    patch discount_url(@discount), params: { discount: { base_item_id: @discount.base_item_id, base_item_quantity: @discount.base_item_quantity, child_item_id: @discount.child_item_id, child_item_quantity: @discount.child_item_quantity, discount_percent: @discount.discount_percent } }
    assert_redirected_to discount_url(@discount)
  end

  test "should destroy discount" do
    assert_difference("Discount.count", -1) do
      delete discount_url(@discount)
    end

    assert_redirected_to discounts_url
  end
end
