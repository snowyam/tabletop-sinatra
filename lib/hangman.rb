module Noose

  def reloaded_sessions
    @word = session[:word]
    @turn = session[:turn]
    @wrong_guesses = session[:wrong_guesses]
    @word_progress = session[:word_progress]
    @status = session[:status]
    @start_state = session[:start_state]
  end

  def turns_left
    session[:turn] -= 1
    if session[:turn] < 1
      session[:start_state] = false
    end
  end

  def guessed(guess)
    guess.to_s.downcase
    if guess.length > 1
      if guess == session[:word]
        # Won by guessing entire word.
        session[:status] = "You guessed: #{session[:word]}. You've won! Play again!"
        session[:word_progress] = session[:word]
        session[:start_state] = false
      else
        # Wrong guess.
        session[:status] = "Nope! Try again!"
        update_wrong(guess)
        turns_left
      end
    else
      if /#{guess}/.match(session[:word]) != nil
        session[:status] = "A match!"
        update_word(guess)
        turns_left
      else
        session[:status] = "No match!"
        update_wrong(guess)
        turns_left
      end
    end
  end

  def display_word_progress
    p session[:word_progress]
  end

  def display_wrong
    session[:wrong_guesses]
  end

  def display_answer
    p session[:word]
  end

  def update_word(guess)
    session[:word].each_char.with_index do |char, index|
      if char == guess
        session[:word_progress][index] = char
      end
    end
    if session[:word] == session[:word_progress]
      # Won by guessing all letters.
      session[:status] = "You guessed: #{session[:word]}. You've won! Play again!"
      session[:word_progress] = session[:word]
      session[:start_state] = false
    end
  end

  def update_wrong(guess)
    session[:wrong_guesses] << guess
  end

  def get_word
    dict = File.readlines("./lib/dict.txt").sample.chomp.downcase
    while dict.length < 5
      dict = File.readlines("./lib/dict.txt").sample.chomp.downcase
    end
    dict
  end

end