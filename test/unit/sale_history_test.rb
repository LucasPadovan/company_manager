require 'test_helper'

class SaleHistoryTest < ActiveSupport::TestCase
  def setup
    @sale_history = Fabricate(:sale_history)
  end

  test 'create' do
    assert_difference ['SaleHistory.count', 'Version.count'] do
      @sale_history = SaleHistory.create(Fabricate.attributes_for(:sale_history))
    end 
  end
    
  test 'update' do
    assert_difference 'Version.count' do
      assert_no_difference 'SaleHistory.count' do
        assert @sale_history.update_attributes(attr: 'Updated')
      end
    end

    assert_equal 'Updated', @sale_history.reload.attr
  end
    
  test 'destroy' do 
    assert_difference 'Version.count' do
      assert_difference('SaleHistory.count', -1) { @sale_history.destroy }
    end
  end
    
  test 'validates blank attributes' do
    @sale_history.attr = ''
    
    assert @sale_history.invalid?
    assert_equal 1, @sale_history.errors.size
    assert_equal [error_message_from_model(@sale_history, :attr, :blank)],
      @sale_history.errors[:attr]
  end
    
  test 'validates unique attributes' do
    new_sale_history = Fabricate(:sale_history)
    @sale_history.attr = new_sale_history.attr

    assert @sale_history.invalid?
    assert_equal 1, @sale_history.errors.size
    assert_equal [error_message_from_model(@sale_history, :attr, :taken)],
      @sale_history.errors[:attr]
  end
end
