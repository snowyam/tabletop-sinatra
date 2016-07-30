require './lib/guesser'
require './lib/caesar'
require './lib/hangman'

class Tabletop < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  not_found do
    erb :error
  end

  get '/' do
    erb :index
  end

  get '/guesser' do
    guess = params["guess"].to_i
    message = check_guess(guess)
    number = reveal_answer(message)
    erb :guesser, :locals => {:number => number, :message => message}
  end

  get '/caesar' do
    erb :caesar
  end

  post '/caesar' do
    @original = params["message"]
    @ciphered = caesar_cipher(@original, params["shift"].to_i)
    erb :caesar
  end

  get '/hangman' do
    erb :hangman
  end
end