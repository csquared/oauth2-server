#!/usr/bin/env rake
require "bundler/gem_tasks"

require 'rake/testtask'

Rake::TestTask.new do |t|
  t.libs << "test"
  t.test_files = FileList['test/**/*_test.rb']
  t.verbose = true
end

task :default => :test

task :env do
  require File.expand_path('../lib/oauth2-server', __FILE__)
end

task :bootstrap => :env do
  client = OAuth2::RegisteredClient.create :client_id => 'client_id',
    :client_secret => 'client_secret',
    :redirect_uri => 'http://localhost:8080/oauth/callback'
  puts "created RegisteredClient: "
  require 'pp'
  pp client.values
end

task :connect => :env do
  require 'oauth2'
  require 'rest-client'
  client = OAuth2::Client.new('client_id', 'client_secret', 
                              :site => 'http://localhost:5000', 
                              :authorize_url => '/authorize', 
                              :token_url => '/token')
  auth_url = client.auth_code.authorize_url(:redirect_uri => 'http://localhost:8080/oauth/callback')
  puts "Auth Url: #{auth_url}"
  code = RestClient.get(auth_url) do |response, request, result, &block| 
    Hash[URI.decode_www_form(URI.parse(response.headers[:location]).query)]['code']
  end
  puts "Auth Code: #{code}"
  token = client.auth_code.get_token(code, :redirect_uri => 'http://localhost:8080/oauth/callback')
  puts "Auth Token: #{token.token}"
  puts "Refresh Token: #{token.refresh_token}"
end

task :do_it_live => :connect
