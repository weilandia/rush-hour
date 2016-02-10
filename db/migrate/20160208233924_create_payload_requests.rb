class CreatePayloadRequests < ActiveRecord::Migration
  def change
    create_table  :payload_requests do |t|
      t.string    :ip
      t.integer   :responded_in
      t.datetime  :requested_at
      t.integer   :url_id
      t.integer   :referred_by_id
      t.integer   :resolution_id
      t.integer   :request_type_id
      t.integer   :event_id
      t.integer   :user_agent_id

      t.timestamps null: false
    end
  end
end
