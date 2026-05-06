# Enter Documentation Here
class Code
  DICTIONARY = 'google-10000-english-no-swears.txt'.freeze

  attr_accessor :secret_word, :correct_guesses, :incorrect_guesses, :remaining_attempts, :current_display

  def initialize
    @secret_word = generate_word
    @correct_guesses = []
    @wrong_guesses = []
    @current_display = []
    welcome_message
    @remaining_attempts = 6
  end

  # When a new game is started, your script should load in the dictionary
  # and randomly select a word between 5 and 12 characters long for the secret word.
  def generate_word
    words = File.readlines(DICTIONARY).map(&:chomp).select { |w| w.length.between?(5, 12) }
    words.sample
  end

  def display_underscores
    @current_display = @secret_word.chars.map { '_' }
    # .join(' ') - might add back but right now it turns current display into a string
  end

  def check_letter(guess)
    found = false
    @secret_word.chars.each_with_index do |letter, index|
      next unless guess == letter

      @correct_guesses << guess unless @correct_guesses.include?(guess)
      @current_display[index] = letter
      @current_display.each_char { |i| }
      found = true
    end
    @wrong_guesses << guess unless @wrong_guesses.include?(guess)
    found
  end

  def welcome_message
    puts 'Welcome to Hangman!'
    puts
    puts 'Guess the secret word one letter at a time.'
    puts 'You have 6 incorrect guesses before the game ends.'
    puts
    puts 'Enter a single lowercase letter each turn.'
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

      # Increment turn counter only for valid guesses
      @remaining_attempts - 1
    else
      puts 'INVALID! Please enter a lower case letter!'
    end
  end

  def valid_guess?(guess)
    guess.length == 1 && guess.match?(/^[a-z]+$/)
  end

  # Player wins if all letters of the secret word are guessed correctly
  def winner?
    current_display[index] = found
  end
end
