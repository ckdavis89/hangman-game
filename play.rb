class Hangman

    def initialize
      @banner = File.read('hangman-ascii.txt')
      @word = words.sample
      @lives = 6
      @word_teaser = ""
      @guesses = []
      @HANGMANPICS = ['''
              +---+
              |   |
                  |
                  |
                  |
                  |
            =========''', '''
              +---+
              |   |
              O   |
                  |
                  |
                  |
            =========''', '''
              +---+
              |   |
              O   |
              |   |
                  |
                  |
            =========''', '''
              +---+
              |   |
              O   |
             /|   |
                  |
                  |
            =========''', '''
              +---+
              |   |
              O   |
             /|\  |
                  |
                  |
            =========''', '''
              +---+
              |   |
              O   |
             /|\  |
             /    |
                  |
            =========''', '''
              +---+
              |   |
              O   |
             /|\  |
             / \  |
                  |
            =========''']
      @word.first.size.times do
        @word_teaser += "_ "
      end
    end

    def words
      [
        ["cricket", "A game played by gentleman"],
        ["jogging", "We are not walking..."],
        ["celebrate", "Remembering special moments"],
        ["continent", "There are 7 of these"],
        ["exotic", "Not from around here..."],
        ["hammerhead", "Tool shaped shark"],
        ["fragile", "Weak, brittle, delicate"],
        ["pineapple", "Taboo pizza topping"],
        ["bobross", "Happy accidents, not mistakes"],
        ["antarctica", "Opposite to the Arctic"]
      ]
    end

    def print_teaser last_guess = nil
      update_teaser(last_guess) unless last_guess.nil?
      puts @word_teaser
    end

    def update_teaser last_guess
      new_teaser = @word_teaser.split

      new_teaser.each_with_index do |letter, index|
        # replace blank values with guessed letter if matches letter in word
        if letter == '_' && @word.first[index] == last_guess
          new_teaser[index] = last_guess
        end
      end

      @word_teaser = new_teaser.join(' ')
    end

    def make_guess
      if @lives > 0
        puts ""
        puts "Guesses: #{ @guesses }"
        puts "Enter a letter"
        guess = gets.chomp
        unless @guesses.include? guess
          if guess.length == 1
            @guesses.append(guess)
          end
        else @guesses.include? guess
          show_hangman
          puts "Please choose a new character you haven't selected previously."
          print_teaser guess
          make_guess
        end

        good_guess = @word.first.include? guess

        if guess == ""
          show_hangman
          puts "Guess can't be blank!"
          puts ""
          print_teaser guess
          make_guess
        elsif guess == "exit"
          puts ""
          puts "Thank you for playing!"
          exit

        #if guess is longer than 1 letter
        elsif guess.length > 1
          show_hangman
          puts "Only guess one letter at a time, please!"
          puts ""
          print_teaser guess
          make_guess

        elsif good_guess
          show_hangman
          puts "You are correct!"
          puts ""
          print_teaser guess

          if @word.first == @word_teaser.split.join
            puts ""
            puts "Congratulations... you have won this round!"
            puts "Would you like to play another round? <y/n>"
            response = gets.chomp
            until response == "y" or response == "n"
              puts "Please enter y or n."
              response = gets.chomp
            end
            if response == "y"
              new_game = Hangman.new
              new_game.begin
            elsif response == "n"
              puts "Maybe another time! Goodbye!"
              exit
            end
          else
            make_guess
          end
        else
          @lives -= 1
          show_hangman
          puts ""
          puts "Sorry... you have #{ @lives } lives left. Try again!"
          puts ""
          print_teaser guess
          make_guess
        end
      else
        puts "Game over... Better luck next time!"
        puts "Would you like to play another round? <y/n>"
        response = gets.chomp
        until response == "y" or response == "n"
          puts "Please enter y or n."
          response = gets.chomp
        end
        if response == "y"
          new_game = Hangman.new
          new_game.begin
        elsif response == "n"
          puts "Maybe another time! Goodbye!"
        end
      end
    end

    def begin
      # ask user for a letter
      puts @banner
      puts ""
      show_hangman
      puts ""
      puts "New game started... your word is #{ @word.first.size } characters long"
      puts "To exit game at any point type 'exit'"
      puts ""
      print_teaser
      puts ""
      puts "Clue: #{ @word.last }"
      make_guess
    end

    def show_hangman
      if @lives == 6
        puts @HANGMANPICS[0]
      elsif @lives == 5
        puts @HANGMANPICS[1]
      elsif @lives == 4
        puts @HANGMANPICS[2]
      elsif @lives == 3
        puts @HANGMANPICS[3]
      elsif @lives == 2
        puts @HANGMANPICS[4]
      elsif @lives == 1
        puts @HANGMANPICS[5]
      else
        puts @HANGMANPICS[6]
      end
    end

end

game = Hangman.new
game.begin
