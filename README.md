# OAuth2::Server

This gem is an implementation of an OAuth2 Authorization Server.

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

#### Setup database (postgresql)

    createdb oauth-server

#### Add DB URL to .env

    echo 'OAUTH2_DB_URL=postgres://localhost/oauth-server' > .env

### Install Dependencies

    gem install foreman
    gem install bundler
    bundle install

### Start it

    formean start

#### Register a Client

    export OAUTH2_DB_URL=postgres://localhost/oauth-server
    bundle exec rake boostrap


#### Get a Token

    $ bundle exec rake do_it_live 

    Auth Url: http://localhost:5000/authorize?response_type=code&client_id=client_id&redirect_uri=http%3A%2F%2Flocalhost%3A8080%2Foauth%2Fcallback
    Auth Code: 5106a892-3b43-48f2-8841-ae0198ec00db
    Auth Token: 6c7c0af3-9158-45bb-b61c-457da066cd08

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
