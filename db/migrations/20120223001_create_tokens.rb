Sequel.migration do
  up do
    create_table :tokens do
      primary_key :id
      String   :access_token
      String   :refresh_token
      String   :token_type
      Integer  :expires_in
      Integer  :authorization_id

      DateTime :created_at
      DateTime :updated_at
    end
  end

  down do
    drop_table :tokens
  end
end
