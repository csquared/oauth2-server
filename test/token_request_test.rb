require_relative 'test_helper'

class TokenRequestTest < RackTestCase
  include OAuth2

  def setup
    RegisteredClient.insert :client_id => 'foo',
                            :redirect_uri => 'http://foo.com/bar',
                            :client_secret => '3456'
    Authorization.insert    :code => '1234', :client_id => 'foo',
                            :redirect_uri => 'http://foo.com/bar'
    stub(Authorization).create { Authorization.first }
  end

  def test_requires_http_basic_auth_with_client_creds
    authorize 'fudge', 'cakes'
    post '/token?code=1234&grant_type=authorization_code'
    assert_equal 401, last_response.status
  end

  def test_grant_type
    authorize 'foo', '3456'
    post '/token?code=1234&grant_type=foo'
    assert_equal 400, last_response.status
  end

  def test_code_matches_issued_code
    authorize 'foo', '3456'
    post '/token?code=poo&grant_type=authorization_code'
    assert_equal 400, last_response.status
  end

  def test_stores_granted_acesss_tokens
    authorize 'foo', '3456'
    post '/token?code=1234&grant_type=authorization_code'

    assert_equal 1, Token.count
    token = Token.first
    assert_equal 3600, token.expires_in
    assert_equal 'example', token.token_type
    assert token.access_token
    assert token.refresh_token
  end

  def test_implements_oauth_response
    authorize 'foo', '3456'
    post '/token?code=1234&grant_type=authorization_code'
    assert_equal 200, last_response.status
    
    json_body = JSON.parse(last_response.body)
    assert json_body['access_token']
    assert_equal 'example', json_body['token_type']
    assert_equal 3600, json_body['expires_in']
    assert json_body['refresh_token']
    assert last_response.headers['Content-Type'].include? 'application/json' 
  end
end

