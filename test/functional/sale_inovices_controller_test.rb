require 'test_helper'

class SaleInovicesControllerTest < ActionController::TestCase

  setup do
    @sale_inovice = Fabricate(:sale_inovice)
    @user = Fabricate(:user)
    sign_in @user
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sale_inovices)
    assert_select '#unexpected_error', false
    assert_template "sale_inovices/index"
  end

  test "should get new" do
    get :new
    assert_response :success
    assert_not_nil assigns(:sale_inovice)
    assert_select '#unexpected_error', false
    assert_template "sale_inovices/new"
  end

  test "should create sale_inovice" do
    assert_difference('SaleInovice.count') do
      post :create, sale_inovice: Fabricate.attributes_for(:sale_inovice)
    end

    assert_redirected_to sale_inovice_url(assigns(:sale_inovice))
  end

  test "should show sale_inovice" do
    get :show, id: @sale_inovice
    assert_response :success
    assert_not_nil assigns(:sale_inovice)
    assert_select '#unexpected_error', false
    assert_template "sale_inovices/show"
  end

  test "should get edit" do
    get :edit, id: @sale_inovice
    assert_response :success
    assert_not_nil assigns(:sale_inovice)
    assert_select '#unexpected_error', false
    assert_template "sale_inovices/edit"
  end

  test "should update sale_inovice" do
    put :update, id: @sale_inovice, 
      sale_inovice: Fabricate.attributes_for(:sale_inovice, attr: 'value')
    assert_redirected_to sale_inovice_url(assigns(:sale_inovice))
  end

  test "should destroy sale_inovice" do
    assert_difference('SaleInovice.count', -1) do
      delete :destroy, id: @sale_inovice
    end

    assert_redirected_to sale_inovices_path
  end
end
