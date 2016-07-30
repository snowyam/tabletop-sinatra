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
    erb :guesser
  end

  get '/caesar' do
    erb :caesar
  end

  get '/hangman' do
    erb :hangman
  end
end