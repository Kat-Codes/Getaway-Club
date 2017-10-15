require_relative 'skytest'
require'certified'
require 'httparty'

def randomcountry(continent, data)
   countrylist = []
   names = []

   continents = data['Continents']
   continents.each do |j|
     if j['Name'].downcase.include?(continent.downcase) or continent.downcase == "any"
       countries = j['Countries']
       countries.each do |i|
          countrylist.push(i['Id'])
          names.push(i['Name'])
       end
     else
       puts j['Name']
       puts continent
     end
     end

   number = countrylist.length
   selection = rand(number)
   return [countrylist[selection], names[selection]]


   #countries = data['Continents'].first['Countries']
   #countries.each do |i|
   #   puts i['Name']
   #end
end

def gethotel(country, checkindate, checkoutdate, minprice, maxprice)
   
  # hotelurl = "https://gateway.skyscanner.net/hotels/v1/prices/search/entity/#{country}?market=GB&locale=en_GB&checkin_date=#{checkindate}&checkout_date=#{checkoutdate}&currency=GBP&adults=1&rooms=1&price_min=#{minprice}&price_max=#{maxprice}&apikey=ha906464854775459164611892547937"

  # hotelresponse = HTTParty.get(hotelurl, format: :json)
  # hotelresponse.parsed_response

  # return hotelresponse 
end

def pickquote(country, startdate, enddate)
   url = "http://partners.api.skyscanner.net/apiservices/geo/v1.0?apiKey=ha906464854775459164611892547937"
   response = HTTParty.get(url, format: :json)
   response = response.parsed_response
 
   quotesdata = findquote(country, startdate, enddate)
   quotes = quotesdata['Quotes']
   places = quotesdata['Places']
   quote = 0
   origincode = 0
   destinationcode = 0
   outboundleg = 0


   if not quotes.nil?
     quote = quotes.first
   end

   if quote.is_a?(Hash) and not quote.nil?
     outboundleg = quote['OutboundLeg']
   end

   if outboundleg.is_a?(Hash) and not outboundleg.nil?
     originid = outboundleg['OriginId']
     destinationid = outboundleg['DestinationId']
     finalorigin = 'Blank'
     finaldestination = 'Blank'
   end

   if not places.nil?
     places.each do |i|
       if i['PlaceId'] == originid
          puts i['Name'] + i['PlaceId'].to_s
          finalorigin = i['Name']
          origincode = i['SkyscannerCode']
       end
       if i['PlaceId'] == destinationid
          puts i['Name'] + i['PlaceId'].to_s
          finaldestination = i['Name']
          destinationcode = i['SkyscannerCode']
       end
     end
   end

   return [quote, finalorigin, finaldestination, origincode, destinationcode]
end

def getinfo(country)
   wikiurl = "http://en.wikivoyage.org/w/api.php?format=json&action=query&prop=extracts&explaintext=1&titles=#{country}&exintro=1"
   wikiresponse = HTTParty.get(wikiurl, format: :json)
   wikiresponse = wikiresponse.parsed_response

   wikipage = wikiresponse["query"]["pages"].first
   
   wikiextract = wikipage[1]["extract"]

   return wikiextract
end

def getfacts(country)
   fixedcountry = country.gsub(' ', '%20')
   resturl = "https://restcountries.eu/rest/v2/name/#{fixedcountry}"
   restresponse = HTTParty.get(resturl, format: :json)
   restresponse = restresponse.parsed_response.first

   if not restresponse.nil?
     flag = restresponse['flag']
     language = restresponse['languages'].first['name']
     currency = restresponse['currencies'].first['name']
     timezone = restresponse['timezones'].first
     capital = restresponse['capital']
     latlng = restresponse['latlng']
     puts latlng
   else
     flag = 0
     language = 0
     currency = 0
     timezone = 0
   end

   return [flag, language, currency, timezone, capital, latlng]
end


def result(continent, datein, dateout)

  url = "http://partners.api.skyscanner.net/apiservices/geo/v1.0?apiKey=ha906464854775459164611892547937"
  response = HTTParty.get(url, format: :json)
  response = response.parsed_response
  done = false

  while done == false do

    choice = randomcountry(continent, response)
    puts choice[1]
    @wiki = getinfo choice[1]
    @facts = getfacts choice[1]
    finalquote = pickquote(choice[0], datein, dateout)
    if (not finalquote.nil?) && (not finalquote[0].nil?) && (not finalquote[1].nil?) && (finalquote[0]['MinPrice'].to_i > @minval.to_i) && (finalquote[0]['MinPrice'].to_i < @maxval.to_i)
      done = true
    end
  end

  originname = finalquote[1]
  destinationname = finalquote[2]
    @fuck =  finalquote[0]['MinPrice']
    finalquote[0]['MinPrice'] *=  @people.to_i
    
  answer = [choice[1], finalquote[0]['MinPrice'].to_s + '0', datein, dateout, originname ,  destinationname]
    
    @adate=datein.gsub("-", '')
    @adateo=dateout.gsub("-", '')
    @adate.slice!(0,2)
    @adateo.slice!(0,2)
    
  @codes = [finalquote[3], finalquote[4]]
    @link =("https://www.skyscanner.net/transport/flights/" + @codes[0] + '/' + @codes[1] + '/' + @adate + '/' + @adateo)
  puts answer
  return answer

end



      
