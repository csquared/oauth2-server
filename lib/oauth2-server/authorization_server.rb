module OAuth2
  class AuthorizationServer < ::Sinatra::Base
    OAuthError     = Class.new(RuntimeError)
    InvalidRequest = Class.new(OAuthError)
  #   InvalidScope   = Class.new(OAuthError)
  #   AccessDenied   = Class.new(OAuthError)
  #   ServerError    = Class.new(OAuthError)
  #   UnauthorizedClient      = Class.new(OAuthError)
  #   UnsupportedResponseType = Class.new(OAuthError)
  #   TemporarilyUnavailable  = Class.new(OAuthError)
    set :raise_errors, false 
    set :show_exceptions, false

    error OAuthError do
      redirect redirect_uri :error => error_name(env['sinatra.error'])
    end

    get '/authorize' do
      client_id = params[:client_id]
      client    = RegisteredClient.where(:client_id => client_id).where(~{:redirect_uri => nil}).first
      halt 400 unless client_id && client 

      @redirect_uri = client.redirect_uri
      raise InvalidRequest unless params[:response_type] == 'code'

      auth = Authorization.create(:code => UUIDTools::UUID.random_create.to_s, 
                                  :client_id => client_id,
                                  :redirect_uri => @redirect_uri)

      redirect redirect_uri :code => auth.code
    end

    post '/token' do
      halt 400 if params[:grant_type] != 'authorization_code'
      auth  = Authorization.first(:code => params[:code])
      halt 400 unless auth
      client = RegisteredClient.first(:client_id => auth[:client_id])
      @auth = Rack::Auth::Basic::Request.new(request.env)
      if @auth.provided? && @auth.basic? && @auth.credentials && 
        @auth.credentials == [auth.client_id, client.client_secret]

        {access_token: UUIDTools::UUID.random_create.to_s, 
         token_type: 'example',
         expires_in: 3600,
         refresh_token: UUIDTools::UUID.random_create.to_s, 
        }.to_json
      else
        halt 401
      end
    end
    
    def redirect_uri(opts = {})
      opts[:state] = params[:state] if params[:state]
      uri = URI.parse(@redirect_uri)
      uri.query ||= '' unless opts.empty?
      uri.query += URI.encode_www_form(opts) if uri.query
      uri.to_s
    end

    ## TODO: move to error class itself
    def error_name(klass)
      underscore(klass.class.name).split(/\//).last 
    end

    def underscore(string)
      string.gsub(/::/, '/').
      gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
      gsub(/([a-z\d])([A-Z])/,'\1_\2').
      tr("-", "_").
      downcase
    end
    ## end 
     
  end
end
