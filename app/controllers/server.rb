require 'json'
require_relative '../lib/register_client'
require_relative '../lib/build_payload'
require 'useragent'
require 'digest/sha1'
module RushHour
  class Server < Sinatra::Base
    include RegisterClient
    include BuildPayload

    post "/sources" do
      code, message = register_client(params)
      status code
      body message
    end

    post '/sources/:client/data' do
      code, message = build_payload(params)
      status code
      body message
    end

    not_found do
    erb :error
    end
  end
end
