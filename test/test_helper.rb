ENV['OAUTH2_DB_URL'] = 'postgres://localhost/oauth-server-test'

require 'test/unit'
Bundler.require :test

require 'oauth2-server'

require_relative 'rack_test_case'
