require 'test_helper'

class PurchaseInvoicesControllerTest < ActionController::TestCase
  #
  #setup do
  #  @purchase_invoice = Fabricate(:purchase_invoice)
  #  @user = Fabricate(:user)
  #  sign_in @user
  #end
  #
  #test "should get index" do
  #  get :index
  #  assert_response :success
  #  assert_not_nil assigns(:purchase_invoices)
  #  assert_select '#unexpected_error', false
  #  assert_template "purchase_invoices/index"
  #end
  #
  #test "should get new" do
  #  get :new
  #  assert_response :success
  #  assert_not_nil assigns(:purchase_invoice)
  #  assert_select '#unexpected_error', false
  #  assert_template "purchase_invoices/new"
  #end
  #
  #test "should create purchase_invoice" do
  #  assert_difference('PurchaseInvoice.count') do
  #    post :create, purchase_invoice: Fabricate.attributes_for(:purchase_invoice)
  #  end
  #
  #  assert_redirected_to purchase_invoice_url(assigns(:purchase_invoice))
  #end
  #
  #test "should show purchase_invoice" do
  #  get :show, id: @purchase_invoice
  #  assert_response :success
  #  assert_not_nil assigns(:purchase_invoice)
  #  assert_select '#unexpected_error', false
  #  assert_template "purchase_invoices/show"
  #end
  #
  #test "should get edit" do
  #  get :edit, id: @purchase_invoice
  #  assert_response :success
  #  assert_not_nil assigns(:purchase_invoice)
  #  assert_select '#unexpected_error', false
  #  assert_template "purchase_invoices/edit"
  #end
  #
  #test "should update purchase_invoice" do
  #  put :update, id: @purchase_invoice,
  #    purchase_invoice: Fabricate.attributes_for(:purchase_invoice, attr: 'value')
  #  assert_redirected_to purchase_invoice_url(assigns(:purchase_invoice))
  #end
  #
  #test "should destroy purchase_invoice" do
  #  assert_difference('PurchaseInvoice.count', -1) do
  #    delete :destroy, id: @purchase_invoice
  #  end
  #
  #  assert_redirected_to purchase_invoices_path
  #end
end
