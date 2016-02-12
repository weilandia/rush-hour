require 'json'
require_relative '../lib/register_client'
require_relative '../lib/build_payload'
require 'digest/sha1'
module RushHour
  class Server < Sinatra::Base
    include RegisterClient

    post "/sources" do
      code, message = register_client(params)
      status code
      body message
        # if message.contains?('payload already exists') can't use 403 because of mult 403 requests and we have redirection issue
        #   redirect '/errors'
        # end
      # redirect "/sources/#{params['identifier']}"
    end

    post '/sources/:client/data' do
      payload = BuildPayload.new(params)
      status payload.code
      body payload.message
    end

    get '/sources/:client' do
      @client = Client.find_by(identifier: params[:client])
      if @client.nil?
        redirect "/sources/signup/#{params[:client]}"
      elsif @client.no_payloads?
        erb :new_client
        # some view to indicate there are no payloads
      else
        erb :statistics
      end
    end

    get '/sources/signup/:client' do
      erb :signup
    end

    get '/sources/:client/urls/:path' do
      erb :url_statistics
    end

    get '/errors' do
      erb :user_errors
    end

    not_found do
    erb :error
    end
  end


end
