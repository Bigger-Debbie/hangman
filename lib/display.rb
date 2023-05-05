class Display
    def initialize(word)
        @word = word
        @game_board = Array.new(@word.length, "_")
        @bad_guesses = 0
    end

    def draw
        puts @game_board.join(" ")
    end

    def update(choice)
        split_word = @word.split('')
        split_word.each_with_index do |letter, index|
            if letter == choice
                @game_board[index] = letter.capitalize
            else
                @bad_guesses += 1
            end
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