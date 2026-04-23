class Hangman
  DICTIONARY = 'google-10000-english-no-swears.txt'

  attr_accessor :secret, :correct_guesses, :incorrect_guesses, :remaining_attempts, :current_display

  def initialize
    @secret_word = secret_word
    @correct_guesses = []
    @wrong_guesses = []
    @remaining_attempts = 6
    @current_display = []
  end

  def intro_message
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

  # When a new game is started, your script should load in the dictionary
  # and randomly select a word between 5 and 12 characters long for the secret word.
  def secret_word
    words = File.readlines(DICTIONARY).map(&:chomp).select { |w| w.length.between?(5, 12) }
    words.sample
  end

  def display_underscores
    @current_display = @secret_word.chars.map { '_' }.join(' ')
  end

  def player_guess
    print 'Enter a letter: '
    input = gets.chomp
    guess = input.downcase

    if valid_guess?(guess)
      puts 'yes!'
    else
      puts 'INVALID! Please enter a lower case letter!'
    end
  end

  def valid_guess?(guess)
    guess.length == 1 && guess.match?(/^[a-z]+$/)
  end
end

game = Hangman.new
puts game.player_guess
