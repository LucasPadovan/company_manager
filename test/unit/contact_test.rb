require 'test_helper'

class ContactTest < ActiveSupport::TestCase
  #def setup
  #  @contact = Fabricate(:contact)
  #end
  #
  #test 'create' do
  #  assert_difference ['Contact.count', 'Version.count'] do
  #    @contact = Contact.create(Fabricate.attributes_for(:contact))
  #  end
  #end
  #
  #test 'update' do
  #  assert_difference 'Version.count' do
  #    assert_no_difference 'Contact.count' do
  #      assert @contact.update_attributes(attr: 'Updated')
  #    end
  #  end
  #
  #  assert_equal 'Updated', @contact.reload.attr
  #end
  #
  #test 'destroy' do
  #  assert_difference 'Version.count' do
  #    assert_difference('Contact.count', -1) { @contact.destroy }
  #  end
  #end
  #
  #test 'validates blank attributes' do
  #  @contact.attr = ''
  #
  #  assert @contact.invalid?
  #  assert_equal 1, @contact.errors.size
  #  assert_equal [error_message_from_model(@contact, :attr, :blank)],
  #    @contact.errors[:attr]
  #end
  #
  #test 'validates unique attributes' do
  #  new_contact = Fabricate(:contact)
  #  @contact.attr = new_contact.attr
  #
  #  assert @contact.invalid?
  #  assert_equal 1, @contact.errors.size
  #  assert_equal [error_message_from_model(@contact, :attr, :taken)],
  #    @contact.errors[:attr]
  #end
end
