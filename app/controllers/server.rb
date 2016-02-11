require 'json'
require_relative '../lib/register_client'
require_relative '../lib/build_payload'
require 'digest/sha1'
module RushHour
  class Server < Sinatra::Base
    include RegisterClient
    include BuildPayload

    post "/sources" do
      code, message = register_client(params)
      status code
      body message
      # redirect "/sources/#{params['identifier']}"
    end

    post '/sources/:client/data' do
      code, message = build_payload(params)
      status code
      body message
    end

    get '/sources/:client' do
      @client = Client.find_by(identifier: params[:client])
      if @client.nil?
        redirect "/sources/signup/#{params[:client]}"
      elsif @client.no_payloads?
        # some view to indicate there are no payloads
      else
        erb :statistics
      end
    end

    get '/sources/signup/:client' do
      erb :signup
    end

    not_found do
    erb :error
    end
  end
end
