module CrewCornerOauth
  mattr_accessor :consumer

  def self.get_request_token(callback_url)
    consumer.get_request_token(:oauth_callback => callback_url) do |body|
      params = JSON.parse(body)
      {
        oauth_token: params['oauth_token'],
        oauth_token_secret: params['oauth_token_secret']
      }
    end
  end

  def self.get_access_token(request_token, oauth_verifier)
    access_token = request_token.get_access_token(:oauth_verifier => oauth_verifier)
    body = JSON.parse(access_token.params.first[0].to_s)

    access_token.params = {
      oauth_token: body['oauth_token'],
      oauth_token_secret: body['oauth_token_secret']
    }

    access_token.token = access_token.params[:oauth_token]
    access_token.secret = access_token.params[:oauth_token_secret]

    access_token
  end

  def self.sign_faraday_request!(request, access_token)
    # Mighty hacky way to get the authorization headers by creating the request with OAuth
    # and copying the header over.
    access_token.consumer.request request.method, request.path, access_token do |dummy_request|
      request.headers["Authorization"] = dummy_request["authorization"]

      :done
    end

    request
  end
end
