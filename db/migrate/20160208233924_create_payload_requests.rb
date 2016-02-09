class CreatePayloadRequests < ActiveRecord::Migration
  def change
    create_table :payload_requests do |t|
      t.string    :url
      t.string    :referredBy
      t.string    :requestType
      t.string    :parameters
      t.string    :eventName
      t.string    :userAgent
      t.string    :resolutionWidth
      t.string    :resolutionHeight
      t.string    :ip
      t.integer   :respondedIn
      t.datetime  :requestedAt

      t.timestamps null: false
    end
  end
end
