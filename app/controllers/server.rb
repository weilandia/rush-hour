require 'json'
module RushHour
  class Server < Sinatra::Base
    require 'useragent'
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

      request = client.payload_requests.new(payload) #create table in table request table sha of all attr besides id/time stuff

      if PayloadRequest.exists?(id: params[:identifier])
          status 403
          body "Client #{params[:identifier]} already exists."
      elsif request.save
      elsif payload.values.include?(nil)
        status 400
        body request.errors.full_messages.join("")
      end


    end
# WHAT WE HAVE
# {"url"=>"http://jumpstartlab.com/blog",
#  "requestedAt"=>"2013-02-16 21:38:28 -0700",
#  "respondedIn"=>37,
#  "referredBy"=>"http://jumpstartlab.com",
#  "requestType"=>"GET",
#  "parameters"=>[],
#  "eventName"=>"socialLogin",
#  "userAgent"=>
#   "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
#  "resolutionWidth"=>"1920",
#  "resolutionHeight"=>"1280",
#  "ip"=>"63.29.38.211"}

# WHAT WE NEED
    # payload_base_4 = {
      # "requested_at":"2013-02-16 21:38:28 -0700",
      # "responded_in":130,
      # "ip":"63.29.38.211",
      # "referral_id": @referral_3.id,
      # "url_id": @url_1.id,
      # "request_type_id": @request_type.id,
      # "event_id": @event2.id,
      # "user_agent_id": @user_agent2.id,
      # "resolution_id": @resolution.id,
      # "client_id": @client_2.id
    # }

    not_found do
      erb :error
    end

  def no_client(identifier)
    status 403
    body "Client #{identifier} does not exist."
  end
  end
end
