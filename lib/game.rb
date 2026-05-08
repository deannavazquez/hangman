require_relative 'code'

# The Game class controls:
# 1. Player interaction (input/output)
# 2. Turn tracking
# 3. Win / lose logic
# 4. The main game loop
class Game
  def initialize
    welcome_message
    @code = Code.new
  end

  def welcome_message
    puts 'Welcome to Hangman!'
    puts
    puts 'Guess the secret word one letter at a time.'
    puts 'You have 6 incorrect guesses before the game ends.'
    puts
    puts 'Enter a single letter each turn.'
    puts 'Correct guesses will reveal their position in the word.'
    puts 'Incorrect guesses will be tracked.'
    puts
    puts 'Let’s begin!'
  end

  # Handles one turn of player input.
  # This method:
  # - Prompts the player
  # - Converts input into usable format
  # - Validates the guess
  # - Sends the guess to Code for evaluation
  def player_guess
    print 'Enter a letter: '
    input = gets.chomp
    guess = input.downcase

    if valid_guess?(guess)
      # Send guess to Code class for match calculation
      @code.check_letter(guess)
    else
      puts 'INVALID! Please enter a lower case letter!'
    end
  end

  def valid_guess?(guess)
    guess.length == 1 && guess.match?(/^[a-z]+$/)
  end

  # Player wins if all letters of the secret word are guessed correctly
  def winner?
    @display.none?('_')
  end

  def game_over?
    winner? || @remaining_attempts.zero?
  end

  def play
    loop do
      player_guess

      if winner?
        puts "You win! The word was: #{secret_word}"
      elsif game_over?
        puts "No more guesses! The word was '#{secret_word}' 😬"
      end
    end
  end
end
