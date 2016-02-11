require_relative '../lib/create_attributes'
module BuildPayload
  include CreateAttributes

  def build_payload(params)
    return no_client(params) if no_client?(params)
    raw_payload = JSON.parse(params[:payload])

    client = Client.find_by(identifier: params[:client])

    payload = payload_hash(raw_payload, client)

    request = client.payload_requests.new(payload)
    if payload_already_exists(request, client)
      [403, ""]
    elsif request.save
      [200,""]
    elsif payload.values.include?(nil)
      [400, request.errors.full_messages.join("")]
    end
  end

  def payload_already_exists(request, client)
    sha1 = payload_request_sha1(request)
    client.payload_requests.all.map{|r| payload_request_sha1(r)}.include?(sha1)
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
      "client_id" => client.id
    }
  end

  def payload_request_sha1(request)
    unique_checks =
    [
       request.ip,
       request.referral.referral_path,
       request.url.path,
       request.request_type.verb,
       request.event.name,
       request.agent.browser,
       request.agent.platform,
       request.resolution.height,
       request.resolution.width,
       request.client.identifier,
       request.client.root_url
    ]

    to_sha1 = unique_checks.join("-")
    Digest::SHA1.hexdigest(to_sha1)
  end

  def no_client?(params)
    !Client.exists?(identifier: params[:client])
  end

  def no_client(params)
    [403, "Client #{params[:client]} does not exist."]
  end
end
