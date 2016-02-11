class AddShaToPayloadRequests < ActiveRecord::Migration
  def change
    add_column :payload_requests, :digest, :string
  end
end
