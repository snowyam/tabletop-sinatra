require 'sinatra'
require 'sinatra/reloader' if development?

number = rand(101)

get '/' do
  "The secret number is #{number}".upcase
end