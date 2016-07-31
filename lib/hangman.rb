module Noose

  def reloaded_sessions
    @word = session[:word]
    @turn = session[:turn]
    @wrong_guesses = session[:wrong_guesses]
    @word_progress = session[:word_progress]
    @start_state = session[:start_state]
  end

  def turns_left
    @turn -= 1
    @turn
  end

  def guessed(guess)
    guess.to_s.downcase
    if guess.length > 1
      if guess == session[:word]
        # Won by guessing entire word.
        @turn = 1
      end
    else
      if /#{guess}/.match(session[:word]) != nil
        # A match
        update_word(guess)
      else
        # No match.
        update_wrong(guess)
      end
    end
  end

  def display_word_progress
    session[:word_progress]
  end

  def display_wrong
    p session[:wrong_guesses]
  end

  def display_answer
    session[:word]
  end

  def update_word(guess)
    session[:word].each_char.with_index do |char, index|
      if char == guess
        session[:word_progress][index] = char
      end
    end
    if session[:word] == session[:word_progress]
      # Won by guessing all letters.
      @turn = 1
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