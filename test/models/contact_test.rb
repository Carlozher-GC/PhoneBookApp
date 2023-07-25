require "test_helper"

class ContactTest < ActiveSupport::TestCase
  test "Should fail creating a contact without first_name" do
    contact = Contact.new(last_name: 'test', phone: '0123456789')
    assert_not contact.save
    assert contact.errors.attribute_names.include?(:first_name)
  end

  test "Should fail creating a contact without last_name" do
    contact = Contact.new(first_name: 'test', phone: '0123456789')
    assert_not contact.save
    assert contact.errors.attribute_names.include?(:last_name)
  end

  test "Should fail creating a contact without phone" do
    contact = Contact.new(first_name: 'test', last_name: 'test')
    assert_not contact.save
    assert contact.errors.attribute_names.include?(:phone)
  end

  test "Should fail creating a contact with a phone not having exactly 10 digits" do
    contact = Contact.new(first_name: 'test', last_name: 'test', phone: '0123')
    assert_not contact.save
    assert contact.errors.attribute_names.include?(:phone)

    contact.phone = '01234567890'
    assert_not contact.save
    assert contact.errors.attribute_names.include?(:phone)

    contact.phone = 'abcdefghij'
    assert_not contact.save
    assert contact.errors.attribute_names.include?(:phone)
  end
end
