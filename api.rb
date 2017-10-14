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
   puts countrylist[rand(number)]


   #countries = data['Continents'].first['Countries']
   #countries.each do |i|
   #   puts i['Name']
   #end
end

randomcountry response

      
