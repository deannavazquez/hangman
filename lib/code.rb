class Code
  DICTIONARY = File.expand_path(
    'google-10000-english-no-swears.txt',
    __dir__
  )

  attr_accessor :secret_word,
                :wrong_guesses,
                :remaining_attempts,
                :display

  def initialize(
    secret_word = nil,
    wrong_guesses = [],
    display = nil,
    remaining_attempts = 6
  )
    @secret_word = secret_word || generate_word
    @wrong_guesses = wrong_guesses

    @display = display || @secret_word.chars.map { '_' }

    @remaining_attempts = remaining_attempts
  end

  def generate_word
    words = File.readlines(DICTIONARY)
                .map(&:chomp)
                .select { |word| word.length.between?(5, 12) }

    words.sample
  end

  def check_letter(guess)
    found = false

    @secret_word.chars.each_with_index do |letter, index|
      next unless guess == letter

      @display[index] = letter
      found = true
    end

    unless found || @wrong_guesses.include?(guess)
      @wrong_guesses << guess
      @remaining_attempts -= 1
    end

    found
  end
end
