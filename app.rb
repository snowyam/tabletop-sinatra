require './lib/guesser'
require './lib/caesar'
require './lib/hangman'

class Tabletop < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  enable :sessions

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
    reloaded_sessions
    erb :hangman
  end

  get '/hangman/start' do
    session[:word] = get_word  
    session[:turn] = session[:word].length + 2
    session[:wrong_guesses] = []
    session[:word_progress] = ""

    session[:word].split("").each do |i|
      session[:word_progress] << ("_")
    end

    session[:start_state] = true
    redirect to('/hangman')
  end

  helpers Noose
end