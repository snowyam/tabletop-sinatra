=begin
class Noose
  attr_accessor :word, :turn, :wrong_guesses, :word_progress
  def initialize(word, turn)
    @word = word
    @turn = turn
    @wrong_guesses = []
    @word_progress = ""
    word.split("").each do |i|
      @word_progress << ("_")
    end
  end

  def turns_left
    @turn -= 1
    @turn
  end

  def guessed(guess)
    if guess.length > 1
      if guess == @word
        # Won by entire word
        @turn = 1
      end
    else
      if /#{guess}/.match(@word) != nil
        # A match
        update_word(guess)
      else
        # Wrong, try again.
        update_wrong(guess)
      end
    end
  end

  def display_word_progress
    puts @word_progress
  end

  def display_wrong
    p @wrong_guesses
  end

  def display_answer
    puts @word
  end

  def update_word(guess)
    @word.each_char.with_index do |char, index|
      if char == guess
        @word_progress[index] = char
      end
    end
    if @word == @word_progress
      # Won
      @turn = 1
    end
  end

  def update_wrong(guess)
    @wrong_guesses << guess
  end

end


def guess_input(guess)
  guess = guess.to_s.downcase
  guess
end

def get_word
  dict = File.readlines("./lib/dict.txt").sample.chomp.downcase
  while dict.length < 5
    dict = File.readlines("./lib/dict.txt").sample.chomp.downcase
  end
  return dict
end

# Main game loop
exit = false
start = true

while !exit
  # Main menu: Start game, load word, load game option
  if start == true   
    chosen_word = get_word
    noose = Noose.new(chosen_word, chosen_word.length + 2)
    start = false
  end

  if noose.turns_left > 0
    # Hangman Progress
    noose.display_word_progress
    # Attempts
    noose.display_wrong
    # Enter guess
    guess = guess_input(gets.chomp)
    noose.guessed(guess)
  else
    # answer
    noose.display_answer 
    # Game over
    exit = true
  end
end
=end