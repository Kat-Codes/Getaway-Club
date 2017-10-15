require 'sinatra'
require 'erb'
require_relative 'skytest'
require_relative 'api'

disable :show_exceptions

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
  @continentPreference=params[:ContinentChoice]
  puts(@datein + @dateout)
    
  @final = result(@continentPreference, @datein, @dateout)
  puts @final
  erb :holiday
end

error do
  erb :index
end

def swapdate(dateIn)
  dateArr = dateIn.split('/')
  return "#{dateArr[2]}-#{dateArr[0]}-#{dateArr[1]}"
end
