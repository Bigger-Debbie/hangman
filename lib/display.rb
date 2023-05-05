class Display
    attr_reader :bad_guesses, :guesses, :word

    def initialize(word)
        @word = word
        @game_board = Array.new(@word.length, "_")
        @guesses = Array.new
        @bad_guesses = 0
    end

    def draw
        puts @game_board.join(" ")
    end

    def update(choice)
        @guesses.push(choice.capitalize)
        good_guess = false
        split_word = @word.split('')

        split_word.each_with_index do |letter, index|
            if letter == choice
                @game_board[index] = letter.capitalize
                good_guess = true
            end
        end

        if good_guess == false
            @bad_guesses += 1
        end
    end

    def check_status
        if !@game_board.include?("_")
            return "winner"
        elsif @bad_guesses == 6
            return "looser"
        end
    end
end