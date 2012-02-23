class RackTestCase < Test::Unit::TestCase
  include Rack::Test::Methods
  include RR::Adapters::TestUnit

  def app
    OAuth2::AuthorizationServer
  end

  def teardown
    WebMock.reset!
    [:registered_clients].each{|x| Sequel::Model.db.from(x).truncate}
  end
  
=begin
  def run(*args, &block)
    Sequel::Model.db.transaction(:rollback=>:always){super}
  end
=end
end
