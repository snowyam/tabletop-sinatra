require 'sinatra'
require 'sinatra/reloader' if development?

SECRET_NUMBER = rand(101)

def check_guess(guess)
  if guess > SECRET_NUMBER
    if guess > SECRET_NUMBER + 5
      message = "Way too high!"
    else
      message = "Too high!"
    end
  elsif guess < SECRET_NUMBER
    if guess < SECRET_NUMBER - 5
      message = "Way too low!"
    else
      message = "Too low!"
    end
  else
    message = "You got it right!"
  end
  return message
end

def reveal_answer(message)
  if message == "You got it right!"
    return SECRET_NUMBER
  else
    return "?"
  end
end

get '/' do
  guess = params["guess"].to_i
  message = check_guess(guess)
  number = reveal_answer(message)
  erb :index, :locals => {:number => number, :message => message}
end