# 🎯 Hangman

![Ruby](https://img.shields.io/badge/Ruby-3.x-red) ![The Odin Project](https://img.shields.io/badge/The%20Odin%20Project-Files%20%26%20Serialization-green)

A command-line Hangman game built in Ruby. Guess the secret word letter by letter — save your progress at any time and pick up right where you left off.

---

## Features

- **Dictionary-backed words** — sourced from Google's top 10,000 English words (no swears), filtered to 5–12 characters
- **Live game display** — shows guessed letters, remaining attempts, and partially revealed word each turn
- **Save & load** — serialize game state to disk at any turn; resume any saved game on startup
- **Case-insensitive input** — accepts uppercase and lowercase guesses interchangeably

## Getting started

### Prerequisites
- Ruby 3.x

### Setup

```bash
git clone https://github.com/your-username/hangman.git
cd hangman
```

Download the word list from [first20hours/google-10000-english](https://github.com/first20hours/google-10000-english) and place it in the project root:

```bash
curl -O https://raw.githubusercontent.com/first20hours/google-10000-english/master/google-10000-english-no-swears.txt
```

### Run

```bash
ruby hangman.rb
```

## How to play

1. On launch, choose **New Game** or **Load Saved Game**.
2. A secret word (5–12 letters) is randomly selected from the dictionary.
3. Each turn, the board shows:
   - The word with correct guesses revealed (e.g. `_ r o g r a _ _ i n g`)
   - Incorrect letters guessed so far
   - Remaining incorrect guesses allowed
4. Type a letter to guess, or type `save` to save and exit.
5. Run out of guesses → game over. Reveal all letters → you win!

## Save & load

At the start of any turn, enter `save` to serialize the current game state to a file in `saved_games/`. When you relaunch the program, you'll be prompted to load any saved game and resume exactly where you left off.

Serialization uses Ruby's **YAML** module to persist the full game object — secret word, guessed letters, and remaining attempts.

## Project structure
mastermind/
│
├── lib/
│   ├── code.rb      # Generates and evaluates the secret code
│   └── game.rb      # Handles game flow, turns, and player interaction
│
└── main.rb          # Entry point that starts the game
