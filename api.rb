require 'httparty'

url = "http://partners.api.skyscanner.net/apiservices/geo/v1.0?apiKey=ha906464854775459164611892547937"

response = HTTParty.get(url)
response.parsed_response

puts response
