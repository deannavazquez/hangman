class Hangman
  DICTIONARY = 'google-10000-english-no-swears.txt'

  attr_accessor :secret, :correct_guesses, :incorrect_guesses, :remaining_attempts, :current_display

  def initialize
    @secret_word = secret_word
    @correct_guesses = 0
    @incorrect_guesses = 0
    @remaining_attempts = 0
    @current_display = []
  end

  # When a new game is started, your script should load in the dictionary
  # and randomly select a word between 5 and 12 characters long for the secret word.
  def secret_word
    words = File.readlines(DICTIONARY).map(&:chomp).select { |w| w.length.between?(5, 12) }
    words.sample
  end

  def display_underscores
    # @secret_word.chars.each do |l|
    # l.replace('_')
    @secret_word.chars.map { '_' }.join(' ')
  end
end

game = Hangman.new
puts game.display_underscores
