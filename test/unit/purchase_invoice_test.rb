require 'test_helper'

class PurchaseInvoiceTest < ActiveSupport::TestCase
  #def setup
  #  @purchase_invoice = Fabricate(:purchase_invoice)
  #end
  #
  #test 'create' do
  #  assert_difference ['PurchaseInvoice.count', 'Version.count'] do
  #    @purchase_invoice = PurchaseInvoice.create(Fabricate.attributes_for(:purchase_invoice))
  #  end
  #end
  #
  #test 'update' do
  #  assert_difference 'Version.count' do
  #    assert_no_difference 'PurchaseInvoice.count' do
  #      assert @purchase_invoice.update_attributes(attr: 'Updated')
  #    end
  #  end
  #
  #  assert_equal 'Updated', @purchase_invoice.reload.attr
  #end
  #
  #test 'destroy' do
  #  assert_difference 'Version.count' do
  #    assert_difference('PurchaseInvoice.count', -1) { @purchase_invoice.destroy }
  #  end
  #end
  #
  #test 'validates blank attributes' do
  #  @purchase_invoice.attr = ''
  #
  #  assert @purchase_invoice.invalid?
  #  assert_equal 1, @purchase_invoice.errors.size
  #  assert_equal [error_message_from_model(@purchase_invoice, :attr, :blank)],
  #    @purchase_invoice.errors[:attr]
  #end
  #
  #test 'validates unique attributes' do
  #  new_purchase_invoice = Fabricate(:purchase_invoice)
  #  @purchase_invoice.attr = new_purchase_invoice.attr
  #
  #  assert @purchase_invoice.invalid?
  #  assert_equal 1, @purchase_invoice.errors.size
  #  assert_equal [error_message_from_model(@purchase_invoice, :attr, :taken)],
  #    @purchase_invoice.errors[:attr]
  #end
end
