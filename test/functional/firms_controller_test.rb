require 'test_helper'

class FirmsControllerTest < ActionController::TestCase

  setup do
    @firm = Fabricate(:firm)
    @user = Fabricate(:user)
    sign_in @user
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:firms)
    assert_select '#unexpected_error', false
    assert_template "firms/index"
  end

  test "should get new" do
    get :new
    assert_response :success
    assert_not_nil assigns(:firm)
    assert_select '#unexpected_error', false
    assert_template "firms/new"
  end

  test "should create firm" do
    assert_difference('Firm.count') do
      post :create, firm: Fabricate.attributes_for(:firm)
    end

    assert_redirected_to firm_url(assigns(:firm))
  end

  test "should show firm" do
    get :show, id: @firm
    assert_response :success
    assert_not_nil assigns(:firm)
    assert_select '#unexpected_error', false
    assert_template "firms/show"
  end

  test "should get edit" do
    get :edit, id: @firm
    assert_response :success
    assert_not_nil assigns(:firm)
    assert_select '#unexpected_error', false
    assert_template "firms/edit"
  end

  test "should update firm" do
    put :update, id: @firm, 
      firm: Fabricate.attributes_for(:firm, attr: 'value')
    assert_redirected_to firm_url(assigns(:firm))
  end

  test "should destroy firm" do
    assert_difference('Firm.count', -1) do
      delete :destroy, id: @firm
    end

    assert_redirected_to firms_path
  end
end
