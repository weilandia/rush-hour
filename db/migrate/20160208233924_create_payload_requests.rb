class CreatePayloadRequests < ActiveRecord::Migration
  def change
    create_table  :payload_requests do |t|
      t.string    :ip
      t.integer   :responded_in
      t.datetime  :requested_at
      t.string    :url_id
      t.string    :referred_by_id
      t.string    :resolution_id
      t.string    :request_type_id
      t.string    :event_id
      t.string    :user_agent_id

      t.timestamps null: false
    end
  end
end
