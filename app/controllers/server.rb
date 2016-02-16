require_relative '../lib/register_client'
require_relative '../lib/build_payload'

module RushHour

  class Server < Sinatra::Base

    get '/' do
      erb :index
    end

    get '/login' do
      erb :login
    end

    post '/login' do
      redirect "/sources/#{params[:name]}"
    end

    get '/sources/signup' do
      erb :signup
    end

    post "/sources" do
      client = RegisterClient.new(params)
      status client.code
      body client.message
      if status == 403
        body
      elsif status == 200
        erb :thanks
      end
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
