class RegisterClient
  attr_reader :code, :message

  def initialize(params)
    result = register_client(params)
    @code = result[0]
    @message = result[1]
  end

  def register_client(params)
    data = { identifier: params[:identifier], root_url: params[:rootUrl] }
    client = Client.new(data)

    if Client.exists?(identifier: params[:identifier])
      [403, "Client #{params[:identifier]} already exists."]
    elsif client.save
      [200, ""]
    else
      [400, client.errors.full_messages.join("")]
    end
  end
end
