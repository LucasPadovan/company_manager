require 'test_helper'

class FirmTest < ActiveSupport::TestCase
  def setup
    @firm = Fabricate(:firm)
  end

  test 'create' do
    assert_difference ['Firm.count', 'Version.count'] do
      @firm = Firm.create(Fabricate.attributes_for(:firm))
    end 
  end
    
  test 'update' do
    assert_difference 'Version.count' do
      assert_no_difference 'Firm.count' do
        assert @firm.update_attributes(attr: 'Updated')
      end
    end

    assert_equal 'Updated', @firm.reload.attr
  end
    
  test 'destroy' do 
    assert_difference 'Version.count' do
      assert_difference('Firm.count', -1) { @firm.destroy }
    end
  end
    
  test 'validates blank attributes' do
    @firm.attr = ''
    
    assert @firm.invalid?
    assert_equal 1, @firm.errors.size
    assert_equal [error_message_from_model(@firm, :attr, :blank)],
      @firm.errors[:attr]
  end
    
  test 'validates unique attributes' do
    new_firm = Fabricate(:firm)
    @firm.attr = new_firm.attr

    assert @firm.invalid?
    assert_equal 1, @firm.errors.size
    assert_equal [error_message_from_model(@firm, :attr, :taken)],
      @firm.errors[:attr]
  end
end
