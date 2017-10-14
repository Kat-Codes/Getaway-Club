require 'net/http'
require 'json'
require 'geocoder'
require 'rack'
require 'httparty'

def findquote(startdate, enddate)
  url = "http://partners.api.skyscanner.net/apiservices/browsequotes/v1.0/GB/GBP/gb-GB/GB/anywhere/#{startdate}/#{enddate}?apiKey=ha906464854775459164611892547937"
  response = HTTParty.get(url)
  puts(response.parsed_response)
end

