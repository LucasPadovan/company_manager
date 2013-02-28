require 'test_helper'

class ProductHistoryTest < ActiveSupport::TestCase
  def setup
    @product_history = Fabricate(:product_history)
  end

  test 'create' do
    assert_difference ['ProductHistory.count', 'Version.count'] do
      @product_history = ProductHistory.create(Fabricate.attributes_for(:product_history))
    end 
  end
    
  test 'update' do
    assert_difference 'Version.count' do
      assert_no_difference 'ProductHistory.count' do
        assert @product_history.update_attributes(attr: 'Updated')
      end
    end

    assert_equal 'Updated', @product_history.reload.attr
  end
    
  test 'destroy' do 
    assert_difference 'Version.count' do
      assert_difference('ProductHistory.count', -1) { @product_history.destroy }
    end
  end
    
  test 'validates blank attributes' do
    @product_history.attr = ''
    
    assert @product_history.invalid?
    assert_equal 1, @product_history.errors.size
    assert_equal [error_message_from_model(@product_history, :attr, :blank)],
      @product_history.errors[:attr]
  end
    
  test 'validates unique attributes' do
    new_product_history = Fabricate(:product_history)
    @product_history.attr = new_product_history.attr

    assert @product_history.invalid?
    assert_equal 1, @product_history.errors.size
    assert_equal [error_message_from_model(@product_history, :attr, :taken)],
      @product_history.errors[:attr]
  end
end
