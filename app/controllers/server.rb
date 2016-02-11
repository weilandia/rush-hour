require 'json'
module RushHour
  class Server < Sinatra::Base
    require 'useragent'
    require 'digest/sha1'
    post "/sources" do
      parameters = { identifier: params[:identifier], root_url: params[:rootUrl] }

      client = Client.new(parameters)


      if Client.exists?(identifier: params[:identifier])
        status 403
        body "Client #{params[:identifier]} already exists."
      elsif client.save
      else
        status 400
        body client.errors.full_messages.join("")
      end
    end

    post '/sources/:client/data' do
      raw_payload = JSON.parse(params[:payload])
      parsed_agent = UserAgent.parse(raw_payload["userAgent"])

      return no_client(params[:client]) if !Client.exists?(identifier: params[:client])

      client = Client.find_by(identifier: params[:client])
      # require "pry"; binding.pry

      payload = {
        "requested_at" => raw_payload["requestedAt"],

        "responded_in" => raw_payload["respondedIn"],

        "ip" => raw_payload["ip"],

        "referral_id" => Referral.create({referral_path: raw_payload["referredBy"]}).id,

        "url_id" => Url.create({path: raw_payload["url"]}).id,

        "request_type_id" => RequestType.create({verb: raw_payload["requestType"]}).id,

        "event_id" => Event.create({name: raw_payload["eventName"]}).id,

        "agent_id" => Agent.create({browser: parsed_agent.browser, platform: parsed_agent.platform}).id,

        "resolution_id" => Resolution.create({height: raw_payload["resolutionHeight"], width: raw_payload["resolutionWidth"]}).id,

        "client_id" => client.id
      }


      # Creates a PayloadRequest object from raw data
      request = client.payload_requests.new(payload)

      # Compute sha1 on new PayloadRequest object
      sha1 = payload_request_sha1(request)

      # Retrieve all existing PayloadRequest objects
      # from database and run the sha1 method on them.
      # Check if any of them have same hash as the new objects
      # we are about to upload.
      already_exists = client.payload_requests.all.map{|r| payload_request_sha1(r)}.include?(sha1) #checks if new sha1 is in db
      #compute sha1 for each payload request in db

      if PayloadRequest.exists?(id: params[:identifier])
          status 403
          body "Client #{params[:identifier]} already exists."
      elsif already_exists
        status 403
        #ifthe data is already there, return a 403
      elsif request.save
      elsif payload.values.include?(nil)
        status 400
        body request.errors.full_messages.join("")
      end
    end

    def payload_request_sha1(payload_request) #can use same format for  before/after saving

      unique_checks =
      [  #payload_request.requested_at,
         #payload_request.responded_in,
         payload_request.ip,
         payload_request.referral.referral_path,
         payload_request.url.path,
         payload_request.request_type.verb,
         payload_request.event.name,
         payload_request.agent.browser,
         payload_request.agent.platform,
         payload_request.resolution.height,
         payload_request.resolution.width,
         payload_request.client.identifier,
         payload_request.client.root_url
     ]

     to_sha1 = unique_checks.join("-")
     Digest::SHA1.hexdigest(to_sha1)
    end

    not_found do
      erb :error
    end

  def no_client(identifier)
    status 403
    body "Client #{identifier} does not exist."
  end

  end

end
