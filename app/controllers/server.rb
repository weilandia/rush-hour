require 'json'
module RushHour
  class Server < Sinatra::Base

    post "/sources" do
      parameters = { identifier: params[:identifier], root_url: params[:rootUrl] }

      client = Client.new(parameters)

      if client.save
        body "Did it work?"
      else
        status 400
        body client.errors.full_messages.join("")
      end
    end

    not_found do
      erb :error
    end
  end
end
