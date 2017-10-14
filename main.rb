require 'sinatra'
require 'erb'

get '/' do
    
  erb :index
end


post '/getholiday' do 
  datein = swapdate(params[:datepicker])
  dateout = swapdate(params[:datepicker2])
end

def swapdate(dateIn)
  dateArr = dateIn.split('/')
  return "#{dateArr[2]}-#{dateArr[0]}-#{dateArr[1]}"
end