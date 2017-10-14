require 'sinatra'
require 'erb'

get '/' do
    @submitted = False
    
  erb :index
end

post '/' do
    @submitted = True;
    
    erb :index
end