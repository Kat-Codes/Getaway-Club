require 'net/http'
require 'json'
require 'geocoder'
require 'rack'
require 'google_places'
require 'httparty'

def findquote(country, startdate, enddate)
  url = "http://partners.api.skyscanner.net/apiservices/browsequotes/v1.0/GB/GBP/gb-GB/GB/#{country}/#{startdate}/#{enddate}?apiKey=ha906464854775459164611892547937"
  response = HTTParty.get(url)
  findhotel(country)
  #puts(response.parsed_response)
  return response.parsed_response
end

def findhotel(country)
  mycountry = country
  @client = GooglePlaces::Client.new("AIzaSyBGC_-1md8E6szJgOL2rJ7dpCB3Ocsc1lE")
  puts(@client.spots_by_query('Hotel near ' + mycountry))
end

findhotel("Canada")