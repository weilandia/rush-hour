module CreateAttributes
  def create_agent(raw_payload)
    parsed_agent = UserAgent.parse(raw_payload["userAgent"])
    Agent.create({browser: parsed_agent.browser, platform: parsed_agent.platform}).id
  end

  def create_resolution(raw_payload)
    Resolution.create({height: raw_payload["resolutionHeight"], width: raw_payload["resolutionWidth"]}).id
  end

  def create_event(raw_payload)
    Event.create({name: raw_payload["eventName"]}).id
  end

  def create_request_type(raw_payload)
    RequestType.create({verb: raw_payload["requestType"]}).id
  end

  def create_url(raw_payload)
    Url.create({path: raw_payload["url"]}).id
  end

  def create_referral(raw_payload)
    Referral.create({referral_path: raw_payload["referredBy"]}).id
  end
end
