require 'net/http'
require 'json'
require 'geocoder'
require 'rack'
require 'httparty'

def findquote()
  origin = skysuggest(gets()) 
  url = 'http://partners.api.skyscanner.net/apiservices/browsequotes/v1.0/GB/GBP/gb-GB/GB/anywhere/2017-10-15/2017-10-16?apiKey=ha906464854775459164611892547937'
  response = HTTParty.get(url)
  puts(response.parsed_response)
end

def skysuggest()
  
end

usercurrentlocation()