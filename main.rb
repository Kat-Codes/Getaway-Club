require 'sinatra'
require 'erb'
require_relative 'skytest'
require_relative 'api'

get '/' do
    
  erb :index
end

get 'getholiday' do 
    erb :holiday
end

post '/getholiday' do 
  @datein = swapdate(params[:startdate])
  @dateout = swapdate(params[:enddate])
  @minval = params[:MinValue]
  @maxval = params[:MaxValue]
  @people = params[:PersonCount]
  @continentPreferenct=params[:ContinentChoice]
  puts(@datein + @dateout)
    
  @final = result(@datein, @dateout)
  puts @final
  erb :holiday
end

def swapdate(dateIn)
  dateArr = dateIn.split('/')
  return "#{dateArr[2]}-#{dateArr[0]}-#{dateArr[1]}"
end
