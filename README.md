# OAuth2::Server

This gem is an implementation of an OAuth2 Authoriation Server.

It is designed to work as a standalone server, as a mountable Rack
Endpoint in a rails app, or as a middleware by leveraging Sinatra.

## Installation

Add this line to your application's Gemfile:

    gem 'oauth2-server'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install oauth2-server

## Usage

### Standalone Server

You can just run this server against a local database to experiment with your oauth endpoint
before integrating into your app, or just to be used as a standalone auth server against a 
production system.

#### Setup datbaase

    createdb oauth-server-test

#### Add DB URL to .env

    echo 'OAUTH2_DB_URL=postgres://localhost/oauth-server' > .env

### Install Dependencies

    gem install bundler
    bundle install
    gem install foreman
    formean start

#### Register a Client

    export OAUTH2_DB_URL=postgres://localhost/oauth-server
    bundle exec rake boostrap


#### Get a Token

    bundle exec rake do_it_live 

## Testing

### Setup Test DB

    createdb oauth-server-test

### Install Dependencies

    gem install bundler
    bundle install

### Run 'em

    bundle exec rake




## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
