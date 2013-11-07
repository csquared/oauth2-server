# -*- encoding: utf-8 -*-
require File.expand_path('../lib/oauth2-server/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Chris Continanza"]
  gem.email         = ["christopher.continanza@gmail.com"]
  gem.description   = %q{OAuth2 Authorization Server}
  gem.summary       = %q{TODO: Write a gem summary}
  gem.homepage      = ""

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "oauth2-server"
  gem.require_paths = ["lib"]
  gem.version       = OAuth2::Server::VERSION

  gem.add_development_dependency 'foreman'

  gem.add_dependency 'sinatra'
  gem.add_dependency 'json'
  gem.add_dependency 'uuidtools'
  gem.add_dependency 'pg'
  gem.add_dependency 'sequel'
end
