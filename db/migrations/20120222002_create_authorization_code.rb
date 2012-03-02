Sequel.migration do
  up do
    create_table :authorizations do
      primary_key :Id
      String   :code
      String   :redirect_uri
      String   :client_id

      DateTime :created_at
      DateTime :updated_at
    end
  end

  down do 
    drop_table :authorizations
  end
end
