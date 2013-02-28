require 'test_helper'

class ProductHistoriesControllerTest < ActionController::TestCase

  setup do
    @product_history = Fabricate(:product_history)
    @user = Fabricate(:user)
    sign_in @user
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:product_histories)
    assert_select '#unexpected_error', false
    assert_template "product_histories/index"
  end

  test "should get new" do
    get :new
    assert_response :success
    assert_not_nil assigns(:product_history)
    assert_select '#unexpected_error', false
    assert_template "product_histories/new"
  end

  test "should create product_history" do
    assert_difference('ProductHistory.count') do
      post :create, product_history: Fabricate.attributes_for(:product_history)
    end

    assert_redirected_to product_history_url(assigns(:product_history))
  end

  test "should show product_history" do
    get :show, id: @product_history
    assert_response :success
    assert_not_nil assigns(:product_history)
    assert_select '#unexpected_error', false
    assert_template "product_histories/show"
  end

  test "should get edit" do
    get :edit, id: @product_history
    assert_response :success
    assert_not_nil assigns(:product_history)
    assert_select '#unexpected_error', false
    assert_template "product_histories/edit"
  end

  test "should update product_history" do
    put :update, id: @product_history, 
      product_history: Fabricate.attributes_for(:product_history, attr: 'value')
    assert_redirected_to product_history_url(assigns(:product_history))
  end

  test "should destroy product_history" do
    assert_difference('ProductHistory.count', -1) do
      delete :destroy, id: @product_history
    end

    assert_redirected_to product_histories_path
  end
end
