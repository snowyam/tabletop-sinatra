@@secret_number = rand(101)

def check_guess(guess)
  if guess > @@secret_number
    if guess > @@secret_number + 5
      message = "Way too high!"
    else
      message = "Too high!"
    end
  elsif guess < @@secret_number
    if guess < @@secret_number - 5
      message = "Way too low!"
    else
      message = "Too low!"
    end
  elsif guess == @@secret_number
    message = "You got it right! Play again!"
  else
    message = "Guess the number!"
  end
  return message
end

def reveal_answer(message)
  if message == "You got it right! Play again!"
    answer = @@secret_number
    @@secret_number = rand(101)
    return answer
  else
    return "?"
  end
end