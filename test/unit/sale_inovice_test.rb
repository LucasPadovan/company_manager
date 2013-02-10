require 'test_helper'

class SaleInoviceTest < ActiveSupport::TestCase
  def setup
    @sale_inovice = Fabricate(:sale_inovice)
  end

  test 'create' do
    assert_difference ['SaleInovice.count', 'Version.count'] do
      @sale_inovice = SaleInovice.create(Fabricate.attributes_for(:sale_inovice))
    end 
  end
    
  test 'update' do
    assert_difference 'Version.count' do
      assert_no_difference 'SaleInovice.count' do
        assert @sale_inovice.update_attributes(attr: 'Updated')
      end
    end

    assert_equal 'Updated', @sale_inovice.reload.attr
  end
    
  test 'destroy' do 
    assert_difference 'Version.count' do
      assert_difference('SaleInovice.count', -1) { @sale_inovice.destroy }
    end
  end
    
  test 'validates blank attributes' do
    @sale_inovice.attr = ''
    
    assert @sale_inovice.invalid?
    assert_equal 1, @sale_inovice.errors.size
    assert_equal [error_message_from_model(@sale_inovice, :attr, :blank)],
      @sale_inovice.errors[:attr]
  end
    
  test 'validates unique attributes' do
    new_sale_inovice = Fabricate(:sale_inovice)
    @sale_inovice.attr = new_sale_inovice.attr

    assert @sale_inovice.invalid?
    assert_equal 1, @sale_inovice.errors.size
    assert_equal [error_message_from_model(@sale_inovice, :attr, :taken)],
      @sale_inovice.errors[:attr]
  end
end
