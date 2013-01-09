require 'test_helper'

class ContactsControllerTest < ActionController::TestCase

  setup do
    @contact = Fabricate(:contact)
    @user = Fabricate(:user)
    sign_in @user
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:contacts)
    assert_select '#unexpected_error', false
    assert_template "contacts/index"
  end

  test "should get new" do
    get :new
    assert_response :success
    assert_not_nil assigns(:contact)
    assert_select '#unexpected_error', false
    assert_template "contacts/new"
  end

  test "should create contact" do
    assert_difference('Contact.count') do
      post :create, contact: Fabricate.attributes_for(:contact)
    end

    assert_redirected_to contact_url(assigns(:contact))
  end

  test "should show contact" do
    get :show, id: @contact
    assert_response :success
    assert_not_nil assigns(:contact)
    assert_select '#unexpected_error', false
    assert_template "contacts/show"
  end

  test "should get edit" do
    get :edit, id: @contact
    assert_response :success
    assert_not_nil assigns(:contact)
    assert_select '#unexpected_error', false
    assert_template "contacts/edit"
  end

  test "should update contact" do
    put :update, id: @contact, 
      contact: Fabricate.attributes_for(:contact, attr: 'value')
    assert_redirected_to contact_url(assigns(:contact))
  end

  test "should destroy contact" do
    assert_difference('Contact.count', -1) do
      delete :destroy, id: @contact
    end

    assert_redirected_to contacts_path
  end
end
