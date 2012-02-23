Sequel.migration do
  up do
    create_table :registered_clients do
      String   :client_id
      String   :redirect_uri
      String   :client_secret
      String   :name

      DateTime :created_at
      DateTime :updated_at
    end
  end

  down do
    drop_table :registered_clients
  end
end
