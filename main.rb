require 'sinatra'
require 'erb'
require_relative 'skytest'

get '/' do
    
  erb :index
end


post '/getholiday' do 
  datein = swapdate(params[:startdate])
  dateout = swapdate(params[:enddate])
  puts(datein + dateout)
  findquote(datein, dateout)
    
    erb :holiday
end

def swapdate(dateIn)
  dateArr = dateIn.split('/')
  return "#{dateArr[2]}-#{dateArr[0]}-#{dateArr[1]}"
end