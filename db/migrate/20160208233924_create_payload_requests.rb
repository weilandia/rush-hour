class CreatePayloadRequests < ActiveRecord::Migration
  def change
    create_table :payload_requests do |t|
      t.string    :ip
      t.string    :url
      t.string    :referredBy
      t.string    :parameters
      t.integer   :respondedIn
      t.datetime  :requestedAt
      t.string    :userAgent
      t.string    :resolution_id
      t.string    :request_type_id
      t.string    :event_id
      t.string    :browser_id
      t.string    :platform_id

      t.timestamps null: false
    end
  end
end
