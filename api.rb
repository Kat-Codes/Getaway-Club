require 'httparty'

url = "http://partners.api.skyscanner.net/apiservices/geo/v1.0?apiKey=ha906464854775459164611892547937"

response = HTTParty.get(url, format: :json)
response.parsed_response

def randomcountry data
   countrylist = []

   continents = data['Continents']
   continents.each do |j|
      countries = j['Countries']
     countries.each do |i|
        countrylist.push(i['Name'])
     end
   end

   number = countrylist.length
   return countrylist[rand(number)]


   #countries = data['Continents'].first['Countries']
   #countries.each do |i|
   #   puts i['Name']
   #end
end

def gethotel country checkindate checkoutdate minprice maxprice
   
   hotelurl = "https://gateway.skyscanner.net/hotels/v1/prices/search/entity/#{country}?market=GB&locale=en_GB&checkin_date=#{checkindate}&checkout_date=#{checkoutdate}&currency=GBP&adults=1&rooms=1&price_min=#{minprice}&price_max=#{maxprice}"

      
