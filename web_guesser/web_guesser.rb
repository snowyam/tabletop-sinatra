require 'sinatra'
require 'sinatra/reloader' if development?

number = rand(101)

get '/' do
  erb :index, :locals => {:number => number}
end