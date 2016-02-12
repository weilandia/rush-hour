# use find_or_create_by instead of create

module CreateAttributes
  def create_agent(raw_payload)
    parsed_agent = UserAgent.parse(raw_payload["userAgent"])
    Agent.find_or_create_by({browser: parsed_agent.browser, platform: parsed_agent.platform}).id
  end

  def create_resolution(raw_payload)
    Resolution.find_or_create_by({height: raw_payload["resolutionHeight"], width: raw_payload["resolutionWidth"]}).id
  end

  def create_event(raw_payload)
    Event.find_or_create_by({name: raw_payload["eventName"]}).id
  end

  def create_request_type(raw_payload)
    RequestType.find_or_create_by({verb: raw_payload["requestType"]}).id
  end

  def create_url(raw_payload)
    rel_path = URI(raw_payload["url"]).path
    host = URI(raw_payload["url"]).host
    Url.find_or_create_by({path: raw_payload["url"], host: host, relative_path: rel_path}).id
  end

  def create_referral(raw_payload)
    Referral.find_or_create_by({referral_path: raw_payload["referredBy"]}).id
  end
end
