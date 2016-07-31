module Secret

  def new_secret_number
    session[:secret] = rand(101)
  end

  def check_guess(guess)
    if guess > session[:secret]
      if guess > session[:secret]+ 5
        message = "Way too high!"
      else
        message = "Too high!"
      end
    elsif guess < session[:secret]
      if guess < session[:secret] - 5
        message = "Way too low!"
      else
        message = "Too low!"
      end
    elsif guess == session[:secret]
      message = "You got it right! Play again!"
    else
      message = "Guess the number!"
    end
    return message
  end

  def reveal_answer(message)
    if message == "You got it right! Play again!"
      answer = session[:secret]
      new_secret_number
      return answer
    else
      return "?"
    end
  end

end