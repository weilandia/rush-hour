require_relative '../lib/create_attributes'

class BuildPayload
  include CreateAttributes
  attr_reader :code, :message

  def initialize(params)
    result = build_payload(params)
    @code = result[0]
    @message = result[1]
  end

  def build_payload(params)
    client = Client.find_by(identifier: params[:client])
    return no_client(params) unless client
    raw_payload = JSON.parse(params[:payload])

    payload = payload_hash(raw_payload, client)

    request = client.payload_requests.new(payload)

    if PayloadRequest.exists?(digest: payload["digest"])
      [403, "#{client.identifier.upcase}: payload already exists."]
    elsif request.save
      [200,""]
    elsif payload.values.include?(nil)
      [400, request.errors.full_messages.join("")]
    end
  end

  def payload_hash(raw_payload, client)
    {
      "ip" => raw_payload["ip"],
      "requested_at" => raw_payload["requestedAt"],
      "responded_in" => raw_payload["respondedIn"],
      "referral_id" => create_referral(raw_payload),
      "url_id" => create_url(raw_payload),
      "request_type_id" => create_request_type(raw_payload),
      "event_id" => create_event(raw_payload),
      "agent_id" => create_agent(raw_payload),
      "resolution_id" => create_resolution(raw_payload),
      "client_id" => client.id,
      "digest" => Digest::SHA1.hexdigest(raw_payload.to_s)
    }
  end

  def no_client(params)
    [403, "Client #{params[:client]} does not exist."]
  end
end
