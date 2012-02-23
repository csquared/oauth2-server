require 'sinatra/base'
require 'json'
require 'uuidtools'
require 'pg'
require 'sequel'

require "oauth2-server/authorization_server"

if ENV['OAUTH2_DB_URL']
  Sequel.connect ENV['OAUTH2_DB_URL'] 
  require "oauth2-server/registered_client"
  require "oauth2-server/authorization"
end

require "oauth2-server/version"
