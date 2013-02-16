require 'test_helper'

class SaleinvoicesControllerTest < ActionController::TestCase

  setup do
    @sale_invoice = Fabricate(:sale_invoice)
    @user = Fabricate(:user)
    sign_in @user
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sale_invoices)
    assert_select '#unexpected_error', false
    assert_template "sale_invoices/index"
  end

  test "should get new" do
    get :new
    assert_response :success
    assert_not_nil assigns(:sale_invoice)
    assert_select '#unexpected_error', false
    assert_template "sale_invoices/new"
  end

  test "should create sale_invoice" do
    assert_difference('Saleinvoice.count') do
      post :create, sale_invoice: Fabricate.attributes_for(:sale_invoice)
    end

    assert_redirected_to sale_invoice_url(assigns(:sale_invoice))
  end

  test "should show sale_invoice" do
    get :show, id: @sale_invoice
    assert_response :success
    assert_not_nil assigns(:sale_invoice)
    assert_select '#unexpected_error', false
    assert_template "sale_invoices/show"
  end

  test "should get edit" do
    get :edit, id: @sale_invoice
    assert_response :success
    assert_not_nil assigns(:sale_invoice)
    assert_select '#unexpected_error', false
    assert_template "sale_invoices/edit"
  end

  test "should update sale_invoice" do
    put :update, id: @sale_invoice,
      sale_invoice: Fabricate.attributes_for(:sale_invoice, attr: 'value')
    assert_redirected_to sale_invoice_url(assigns(:sale_invoice))
  end

  test "should destroy sale_invoice" do
    assert_difference('Saleinvoice.count', -1) do
      delete :destroy, id: @sale_invoice
    end

    assert_redirected_to sale_invoices_path
  end
end
