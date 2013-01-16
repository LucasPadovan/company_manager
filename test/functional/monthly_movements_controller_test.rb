require 'test_helper'

class MonthlyMovementsControllerTest < ActionController::TestCase

  #setup do
  #  @monthly_movement = Fabricate(:monthly_movement)
  #  @user = Fabricate(:user)
  #  sign_in @user
  #end
  #
  #test "should get index" do
  #  get :index
  #  assert_response :success
  #  assert_not_nil assigns(:monthly_movements)
  #  assert_select '#unexpected_error', false
  #  assert_template "monthly_movements/index"
  #end
  #
  #test "should get new" do
  #  get :new
  #  assert_response :success
  #  assert_not_nil assigns(:monthly_movement)
  #  assert_select '#unexpected_error', false
  #  assert_template "monthly_movements/new"
  #end
  #
  #test "should create monthly_movement" do
  #  assert_difference('MonthlyMovement.count') do
  #    post :create, monthly_movement: Fabricate.attributes_for(:monthly_movement)
  #  end
  #
  #  assert_redirected_to monthly_movement_url(assigns(:monthly_movement))
  #end
  #
  #test "should show monthly_movement" do
  #  get :show, id: @monthly_movement
  #  assert_response :success
  #  assert_not_nil assigns(:monthly_movement)
  #  assert_select '#unexpected_error', false
  #  assert_template "monthly_movements/show"
  #end
  #
  #test "should get edit" do
  #  get :edit, id: @monthly_movement
  #  assert_response :success
  #  assert_not_nil assigns(:monthly_movement)
  #  assert_select '#unexpected_error', false
  #  assert_template "monthly_movements/edit"
  #end
  #
  #test "should update monthly_movement" do
  #  put :update, id: @monthly_movement,
  #    monthly_movement: Fabricate.attributes_for(:monthly_movement, attr: 'value')
  #  assert_redirected_to monthly_movement_url(assigns(:monthly_movement))
  #end
  #
  #test "should destroy monthly_movement" do
  #  assert_difference('MonthlyMovement.count', -1) do
  #    delete :destroy, id: @monthly_movement
  #  end
  #
  #  assert_redirected_to monthly_movements_path
  #end
end
