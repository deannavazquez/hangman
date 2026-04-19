class Hangman
  DICTIONARY = 'google-10000-english-no-swears.txt'

  # When a new game is started, your script should load in the dictionary
  # and randomly select a word between 5 and 12 characters long for the secret word.
  def secret_word
    words = File.readlines(DICTIONARY).map(&:chomp).select { |w| w.length.between?(5, 12) }
    words.sample
  end
end

game = Hangman.new
puts game.secret_word
