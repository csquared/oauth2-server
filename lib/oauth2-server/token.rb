module OAuth2
  class Token < Sequel::Model

    def to_json
      {
        access_token: access_token,
        token_type: token_type,
        expires_in: expires_in,
        refresh_token: refresh_token
      }.to_json
    end
  end
end
