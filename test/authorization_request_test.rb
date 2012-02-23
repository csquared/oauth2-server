require_relative 'test_helper'

class AuthorizationRequestTest < RackTestCase
  include OAuth2

  def setup
    RegisteredClient.insert :client_id => 'foo',
                            :redirect_uri => 'http://foo.com/bar'
    Authorization.insert    :code => '1234', :client_id => 'foo',
                            :redirect_uri => 'http://foo.com/bar'
    stub(Authorization).create { Authorization.first }
  end

  def test_requires_response_type_of_code
    get "/authorize?client_id=foo&response_type=BLAH"
    assert_equal 302, last_response.status
    assert_equal 'http://foo.com/bar?error=invalid_request', last_response.headers['Location']
  end

  def test_requires_client_id
    get "/authorize?response_type=code"
    assert_equal 400, last_response.status
  end

  def test_includes_state_with_redirect_uri
    get "/authorize?client_id=foo&response_type=code&state=California"
    assert_equal 302, last_response.status
    assert_equal 'http://foo.com/bar?code=1234&state=California', 
      last_response.headers['Location']
  end
end
