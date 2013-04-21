require 'crew_corner'
require 'oauth'
require 'crew_corner_oauth'

CrewCornerOauth.consumer = OAuth::Consumer.new(
  'client key',
  'client secret',
  site: 'http://api.crew.dreamhack.se')

CrewCorner.request_filter = ->(request, options) do
  access_token = options.delete(:access_token)
  CrewCornerOauth.sign_faraday_request!(request, access_token) unless access_token.nil?
end
