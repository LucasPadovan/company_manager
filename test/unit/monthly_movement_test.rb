require 'test_helper'

class MonthlyMovementTest < ActiveSupport::TestCase
  #def setup
  #  @monthly_movement = Fabricate(:monthly_movement)
  #end
  #
  #test 'create' do
  #  assert_difference ['MonthlyMovement.count', 'Version.count'] do
  #    @monthly_movement = MonthlyMovement.create(Fabricate.attributes_for(:monthly_movement))
  #  end
  #end
  #
  #test 'update' do
  #  assert_difference 'Version.count' do
  #    assert_no_difference 'MonthlyMovement.count' do
  #      assert @monthly_movement.update_attributes(attr: 'Updated')
  #    end
  #  end
  #
  #  assert_equal 'Updated', @monthly_movement.reload.attr
  #end
  #
  #test 'destroy' do
  #  assert_difference 'Version.count' do
  #    assert_difference('MonthlyMovement.count', -1) { @monthly_movement.destroy }
  #  end
  #end
  #
  #test 'validates blank attributes' do
  #  @monthly_movement.attr = ''
  #
  #  assert @monthly_movement.invalid?
  #  assert_equal 1, @monthly_movement.errors.size
  #  assert_equal [error_message_from_model(@monthly_movement, :attr, :blank)],
  #    @monthly_movement.errors[:attr]
  #end
  #
  #test 'validates unique attributes' do
  #  new_monthly_movement = Fabricate(:monthly_movement)
  #  @monthly_movement.attr = new_monthly_movement.attr
  #
  #  assert @monthly_movement.invalid?
  #  assert_equal 1, @monthly_movement.errors.size
  #  assert_equal [error_message_from_model(@monthly_movement, :attr, :taken)],
  #    @monthly_movement.errors[:attr]
  #end
end
