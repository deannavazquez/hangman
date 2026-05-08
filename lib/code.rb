# Enter Documentation Here
class Code
  DICTIONARY = 'google-10000-english-no-swears.txt'.freeze

  attr_accessor :secret_word, :wrong_guesses, :remaining_attempts, :display

  def initialize
    @secret_word = generate_word
    @correct_guesses = []
    @wrong_guesses = []
    @display = []
    @remaining_attempts = 6
  end

  # When a new game is started, your script should load in the dictionary
  # and randomly select a word between 5 and 12 characters long for the secret word.
  def generate_word
    words = File.readlines(DICTIONARY).map(&:chomp).select { |w| w.length.between?(5, 12) }
    words.sample
  end

  def display_underscores
    @display = @secret_word.chars.map { '_' }
    # .join(' ')
    # .join(' ') - might add back but right now it turns current display into a string
  end

  def current_display
    p @display # trying to figure out how to display horizontally without puts
  end

  def check_letter(guess)
    puts "Checking #{guess} against #{@secret_word}"
    found = false

    @secret_word.chars.each_with_index do |letter, index|
      if guess == letter
        @display[index] = letter
        found = true
      end
    end

    unless found || @wrong_guesses.include?(guess)
      @wrong_guesses << guess
      @remaining_attempts -= 1
    end

    found
  end
end
