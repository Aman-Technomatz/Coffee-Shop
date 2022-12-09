require "test_helper"

class TaxCategoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @tax_category = tax_categories(:one)
  end

  test "should get index" do
    get tax_categories_url
    assert_response :success
  end

  test "should get new" do
    get new_tax_category_url
    assert_response :success
  end

  test "should create tax_category" do
    assert_difference("TaxCategory.count") do
      post tax_categories_url, params: { tax_category: { tax_rate: @tax_category.tax_rate } }
    end

    assert_redirected_to tax_category_url(TaxCategory.last)
  end

  test "should show tax_category" do
    get tax_category_url(@tax_category)
    assert_response :success
  end

  test "should get edit" do
    get edit_tax_category_url(@tax_category)
    assert_response :success
  end

  test "should update tax_category" do
    patch tax_category_url(@tax_category), params: { tax_category: { tax_rate: @tax_category.tax_rate } }
    assert_redirected_to tax_category_url(@tax_category)
  end

  test "should destroy tax_category" do
    assert_difference("TaxCategory.count", -1) do
      delete tax_category_url(@tax_category)
    end

    assert_redirected_to tax_categories_url
  end
end
