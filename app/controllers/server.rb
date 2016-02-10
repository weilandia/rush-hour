require 'json'
module RushHour
  class Server < Sinatra::Base

    post "/sources" do
      parameters = { identifier: params[:identifier], root_url: params[:rootUrl] }

      client = Client.new(parameters)

      # require "pry"; binding.pry

      if Client.exists?(identifier: params[:identifier])
        status 403
        body "Client #{params[:identifier]} already exists."
      elsif client.save
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
