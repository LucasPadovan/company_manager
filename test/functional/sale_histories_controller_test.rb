require 'test_helper'

class SaleHistoriesControllerTest < ActionController::TestCase

  setup do
    @sale_history = Fabricate(:sale_history)
    @user = Fabricate(:user)
    sign_in @user
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sale_histories)
    assert_select '#unexpected_error', false
    assert_template "sale_histories/index"
  end

  test "should get new" do
    get :new
    assert_response :success
    assert_not_nil assigns(:sale_history)
    assert_select '#unexpected_error', false
    assert_template "sale_histories/new"
  end

  test "should create sale_history" do
    assert_difference('SaleHistory.count') do
      post :create, sale_history: Fabricate.attributes_for(:sale_history)
    end

    assert_redirected_to sale_history_url(assigns(:sale_history))
  end

  test "should show sale_history" do
    get :show, id: @sale_history
    assert_response :success
    assert_not_nil assigns(:sale_history)
    assert_select '#unexpected_error', false
    assert_template "sale_histories/show"
  end

  test "should get edit" do
    get :edit, id: @sale_history
    assert_response :success
    assert_not_nil assigns(:sale_history)
    assert_select '#unexpected_error', false
    assert_template "sale_histories/edit"
  end

  test "should update sale_history" do
    put :update, id: @sale_history, 
      sale_history: Fabricate.attributes_for(:sale_history, attr: 'value')
    assert_redirected_to sale_history_url(assigns(:sale_history))
  end

  test "should destroy sale_history" do
    assert_difference('SaleHistory.count', -1) do
      delete :destroy, id: @sale_history
    end

    assert_redirected_to sale_histories_path
  end
end
