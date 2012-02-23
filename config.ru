# -*- encoding: utf-8 -*-
require File.expand_path('../lib/oauth2-server', __FILE__)
STDOUT.sync = true

run OAuth2::AuthorizationServer
