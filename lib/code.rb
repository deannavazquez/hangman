class Code
  DICTIONARY = 'google-10000-english-no-swears.txt'.freeze

  attr_accessor :secret_word, :correct_guesses, :incorrect_guesses, :remaining_attempts, :current_display

  def initialize
    @secret_word = generate_word
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
  def generate_word
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
      # add match criteria and increment counters
      puts 'yes!'
    else
      puts 'INVALID! Please enter a lower case letter!'
    end
  end

  def valid_guess?(guess)
    guess.length == 1 && guess.match?(/^[a-z]+$/)
  end

  def check_letter(guess)
    found = false
    @secret_word.chars.each_with_index do |letter, index|
      next unless guess == letter

      @correct_guesses << guess unless @correct_guesses.include?(guess)
      @current_display[index] = letter
      found = true
    end
    @wrong_guesses << guess unless @wrong_guesses.include?(guess)
    found
  end
  # puts 'Wrong guesses:' + "#{@wrong_guesses}"
end

# Force a known secret word so tests are predictable
game = Code.new
