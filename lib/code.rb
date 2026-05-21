require 'yaml'

class Code # rubocop:disable Style/Documentation
  DICTIONARY = File.expand_path('google-10000-english-no-swears.txt', __dir__)

  attr_accessor :secret_word, :wrong_guesses,
                :remaining_attempts, :display

  def initialize(secret_word = nil, # rubocop:disable Metrics/ParameterLists
                 wrong_guesses = [],
                 display = nil,
                 remaining_attempts = 6)
    @secret_word = secret_word || generate_word
    @wrong_guesses = wrong_guesses
    @display = display || @secret_word.chars.map { '_' }
    @remaining_attempts = remaining_attempts
  end

  def to_yaml
    YAML.dump({
                secret_word: secret_word,
                wrong_guesses: wrong_guesses,
                display: display,
                remaining_attempts: remaining_attempts
              })
  end

  def self.from_yaml(string)
    data = YAML.safe_load(string)

    new(
      data[:secret_word],
      data[:wrong_guesses],
      data[:display],
      data[:remaining_attempts]
    )
  end

  # When a new game is started, your script should load in the dictionary
  # and randomly select a word between 5 and 12 characters long
  # for the secret word.
  def generate_word
    words = File.readlines(DICTIONARY)
                .map(&:chomp)
                .select { |w| w.length.between?(5, 12) }

    words.sample
  end

  def check_letter(guess) # rubocop:disable Metrics/MethodLength
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
