require 'sinatra'
require 'erb'

get '/' do
    puts "poop"
  erb :index
end