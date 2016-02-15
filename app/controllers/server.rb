require 'json'
require_relative '../lib/register_client'
require_relative '../lib/build_payload'
require 'digest/sha1'
module RushHour
  class Server < Sinatra::Base
    include RegisterClient

    get '/' do
      erb :index
    end

    post "/sources" do
      code, message = register_client(params)
      status code
      body message
      redirect "/sources/#{params['identifier']}", status
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
      else
        erb :statistics
      end
    end

    get '/sources/signup/:client' do
      erb :signup
    end

    get '/sources/:client/urls/:relative_path' do
      client = Client.find_by(identifier: params[:client])
      @url = client.urls.find_by(relative_path: "/#{params[:relative_path]}")
      if @url.nil?
        erb :no_payload_for_path
      else
        erb :url_statistics
      end
    end

    get '/sources/:client/events/:event' do
      client = Client.find_by(identifier: params[:client])
      @event = client.events.find_by(name: "#{params[:event]}")
      if @event.nil?
        erb :no_event
      else
        erb :event_statistics
      end
    end

    not_found do
      erb :error
    end
  end


end
