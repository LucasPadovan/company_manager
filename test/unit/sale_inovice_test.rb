require 'test_helper'

class SaleinvoiceTest < ActiveSupport::TestCase
  def setup
    @sale_invoice = Fabricate(:sale_invoice)
  end

  test 'create' do
    assert_difference ['Saleinvoice.count', 'Version.count'] do
      @sale_invoice = Saleinvoice.create(Fabricate.attributes_for(:sale_invoice))
    end 
  end
    
  test 'update' do
    assert_difference 'Version.count' do
      assert_no_difference 'Saleinvoice.count' do
        assert @sale_invoice.update_attributes(attr: 'Updated')
      end
    end

    assert_equal 'Updated', @sale_invoice.reload.attr
  end
    
  test 'destroy' do 
    assert_difference 'Version.count' do
      assert_difference('Saleinvoice.count', -1) { @sale_invoice.destroy }
    end
  end
    
  test 'validates blank attributes' do
    @sale_invoice.attr = ''
    
    assert @sale_invoice.invalid?
    assert_equal 1, @sale_invoice.errors.size
    assert_equal [error_message_from_model(@sale_invoice, :attr, :blank)],
      @sale_invoice.errors[:attr]
  end
    
  test 'validates unique attributes' do
    new_sale_invoice = Fabricate(:sale_invoice)
    @sale_invoice.attr = new_sale_invoice.attr

    assert @sale_invoice.invalid?
    assert_equal 1, @sale_invoice.errors.size
    assert_equal [error_message_from_model(@sale_invoice, :attr, :taken)],
      @sale_invoice.errors[:attr]
  end
end
