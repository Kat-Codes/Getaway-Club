require 'sinatra'
require 'erb'

get '/' do
    
  erb :index
end

post '/' do
    
    erb :holiday
end