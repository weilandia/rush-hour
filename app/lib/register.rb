class Register

  def initialize(params)
    @params = params
  end

  def register_client
    parameters = client_data(@params)
    client = Client.new(client_data(@params))
    if client_exists?(identifier: @params[:identifier]) then dup_client(parameters)
    elsif success(client)
    else missing_attributes(client)
    end
  end

  def client_data(params)
    { identifier: params[:identifier], root_url: params[:rootUrl] }
  end

  def success(client)
    client.save
    [200, '']
  end

  def client_exists?(parameters)
    Client.exists?(identifier: parameters[:identifier])
  end

  def dup_client(parameters)
    [403, "Client #{parameters[:identifier]} already exists."]
  end

  def missing_attributes(client)
    [400, client.errors.full_messages.join("")]
  end
end
