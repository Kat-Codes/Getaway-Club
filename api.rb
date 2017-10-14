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
   quotesdata = findquote(country, startdate, enddate)
   
   quotes = quotesdata['Quotes']
   quote = quotes.first
   return quote
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
    if (not finalquote.nil?) && (finalquote['MinPrice'].to_i > @minval.to_i) && (finalquote['MinPrice'].to_i < @maxval.to_i)
      done = true
    end
  end

  answer = ["Your destination is " + choice[1] + "!", "Your flight will cost £" + finalquote['MinPrice'].to_s + '0.', datein, dateout]
  puts answer
  return answer

end



      
