require "test_helper"

class ContactsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @contact_1 = contacts(:one)
    @contact_2 = contacts(:two)
  end

  test 'Should succeed GET /contacts' do
      get '/contacts'
      assert_response :success
  end

  test 'Should succeed GET /contacts/new' do
      get '/contacts/new'
      assert_response :success
  end

  test 'Should fail create a contact with an incorrect data' do
    expected_contacts_count = Contact.all.count
    post '/contacts', params: { contact: { first_name: 'test', last_name: 'test', phone: 'incorrect' } }
    assert_response :success
    assert_equal expected_contacts_count, Contact.all.count
  end

  test 'Should succeed create a contact' do
    expected_contacts_count = Contact.all.count + 1
    post '/contacts', params: { contact: { first_name: 'test', last_name: 'test', phone: '0123456789' } }
    assert_response :redirect
    assert_equal expected_contacts_count, Contact.all.count
  end

  test 'Should succeed GET /contacts/:id/new' do
      get "/contacts/#{@contact_1.id}/edit"
      assert_response :success
  end

  test 'Should fail updating a contact with incorrect data' do
    expected_phone = @contact_1.phone
    patch "/contacts/#{@contact_1.id}", params: { contact: { phone: 'incorrect' } }
    assert_response :success
    @contact_1.reload
    assert_equal expected_phone, @contact_1.phone
  end

  test 'Should succeed updating a contact' do
    expected_phone = '9876543210'
    patch "/contacts/#{@contact_1.id}", params: { contact: { phone: expected_phone } }
    assert_response :redirect
    @contact_1.reload
    assert_equal expected_phone, @contact_1.phone
  end

  test 'Should succeed deleting a contact' do
    expected_contacts_count = Contact.all.count - 1
    delete "/contacts/#{@contact_1.id}"
    assert_response :redirect
    assert_equal expected_contacts_count, Contact.all.count
    assert Contact.find_by(id: @contact_1.id).blank?
  end
end
