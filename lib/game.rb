require_relative 'code'
require 'yaml'

class Game
  def initialize(code = Code.new)
    welcome_message
    @code = code
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

  def player_guess # rubocop:disable Metrics/MethodLength
    print "Enter a guess or type 'save': "
    input = gets.chomp
    guess = input.downcase

    if guess == 'save'
      save_game
    elsif valid_guess?(guess)
      if @code.display.include?(guess) || @code.wrong_guesses.include?(guess)
        puts 'You already guessed that letter'
      else
        @code.check_letter(guess)
      end
    else
      puts 'INVALID! Please enter a lower case letter!'
    end
  end

  def valid_guess?(guess)
    guess.length == 1 && guess.match?(/^[a-z]$/)
  end

  def winner?
    @code.display.none?('_')
  end

  def game_over?
    winner? || @code.remaining_attempts.zero?
  end

  def show_board
    puts '-' * 30
    puts "Word: #{@code.display.join(' ')}"
    puts "Wrong guesses: #{@code.wrong_guesses.join(', ')}"
    puts "Attempts left: #{@code.remaining_attempts}"
    puts '-' * 30
  end

  def save_game
    File.open('save.yaml', 'w') do |file|
      file.write(YAML.dump(self))
    end

    puts 'Game saved!'
    exit
  end

  def self.load_game
    yaml_data = File.read('save.yaml')
    YAML.safe_load(
      yaml_data,
      permitted_classes: [Game, Code]
    )
  end

  def loaded_game
    print 'Start a [n]ew game, [c]ontinue a saved one or [e]xit? '
    input = gets.chomp
    choice = input.downcase

    if choice == 'n'
      play
    elsif choice == 'c'
      puts ''
      puts 'Welcome back!'
      Game.load_game.play
    else
      exit
    end
  end

  def play # rubocop:disable Metrics/MethodLength
    loop do
      show_board

      player_guess

      if winner?
        puts "🎉 You win! The word was: #{@code.secret_word}"
        break
      elsif game_over?
        puts "💀 No more guesses! The word was: #{@code.secret_word}"
        break
      end
    end
  end
end
