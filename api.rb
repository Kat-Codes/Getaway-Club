require_relative 'skytest'

require 'httparty'

def randomcountry data
   countrylist = []
   names = []

   continents = data['Continents']
   continents.each do |j|
      countries = j['Countries']
     countries.each do |i|
        countrylist.push(i['Id'])
        names.push(i['Name'])
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
   
   while quotes.nil? do
     quotesdata = findquote(country, startdate, enddate)
     quotes = quotesdata['Quotes']
     places = quotesdata['Places']
   end

   quote = quotes.first

   while quote.nil? do
      quotesdata = findquote(randomcountry(response)[0], startdate, enddate)
      quotes = quotesdata['Quotes']
      places = quotesdata['Places']
      quote = quotes.first
   end


   outboundleg = quote['OutboundLeg']
   originid = outboundleg['OriginId']
   destinationid = outboundleg['DestinationId']
   finalorigin = 'Blank'
   finaldestination = 'Blank'

   places.each do |i|
     if i['PlaceId'] == originid
        puts i['Name'] + i['PlaceId'].to_s
        finalorigin = i['Name']
     end
     if i['PlaceId'] == destinationid
        puts i['Name'] + i['PlaceId'].to_s
        finaldestination = i['Name']
     end
   end

   return [quote, finalorigin, finaldestination]
end
def result(datein, dateout)

  url = "http://partners.api.skyscanner.net/apiservices/geo/v1.0?apiKey=ha906464854775459164611892547937"
  response = HTTParty.get(url, format: :json)
  response = response.parsed_response
  done = false

  while done == false do

    choice = randomcountry(response)
    puts choice[1]
    finalquote = pickquote(choice[0], datein, dateout)
    if (not finalquote.nil?) && (finalquote[0]['MinPrice'].to_i > @minval.to_i) && (finalquote[0]['MinPrice'].to_i < @maxval.to_i)
      done = true
    end
  end

  originname = finalquote[1]
  destinationname = finalquote[2]
    @fuck =  finalquote[0]['MinPrice']
    finalquote[0]['MinPrice'] *=  @people.to_i
    
  answer = [choice[1], finalquote[0]['MinPrice'].to_s + '0', datein, dateout, originname ,  destinationname]
  puts answer
  return answer

end



      
