require_relative 'random_word.rb'
require_relative 'display.rb'

def get_name(path)
    split = path.split("/")
    file_name = split[2].split(".")
    return file_name[0]
end

word = RandomWord.pick_random
display = Display.new(word)
game_over = false

puts "\r\n\t\t HANGMAN"
puts "\r\nGoal Is To Guess The Word One Letter At A Time."
puts "You Can Make Six Bad Guesses Before Loosing..."
print "\r\nPlease Enter Your Name: "
name = gets.chomp.strip

if !Dir.glob("../saves/*.yaml").empty?
    print "Would You Like To Load A Save File? (y/n): "
    while answer = gets.chomp.strip.downcase
        if answer == 'y' || answer == 'n'
            break
        else
            print "Please Enter 'y' Or 'n', Try Again: "
        end
    end

    if answer == 'y'
        saves = Dir.glob("../saves/*.yaml")
        puts "\r\nChoose A Save From The List Below -\n\r\n"
        saves.each {|save| puts "- #{get_name(save)}"}
        print "\r\nEnter Save To Load: "
        while load_file = gets.chomp.strip
            if !saves.include?("../saves/#{load_file}.yaml")
                puts "That Save Does Not Exist, Choose From The List Above."
                print "Enter Date To Load (00-00-00): "
            else
                break
            end
        end

        display = Display.load("../saves/#{load_file}.yaml")
    end
end

puts "During Any Turn, Enter 'sq' To Save & Quit..."

while game_over == false
    save_quit = false

    puts " "
    display.draw
    puts "\r\nBad Guesses: #{display.bad_guesses}"
    puts "Guesses: #{display.guesses.join(", ")}"
    print "Enter Your Guess: "
    while guess = gets.chomp.strip.downcase
        if guess == 'sq'
            save_quit = true
            break
        end

        if guess.length != 1
            print "Guess Must Be A Single Letter: "
        elsif !guess.match?(/[[:alpha:]]/)
            print "Guess Must Be A Letter: "
        else
            break
        end
    end

    if save_quit == true
        print "Enter Save Name: "
        save_name = gets.chomp.strip
        display.save(save_name)
        break
    end

    display.update(guess)
    check = display.check_status
    if check == "winner"
        puts " "
        display.draw
        puts "\r\n#{name.capitalize}, Nice Work. You WON!!"
        game_over = true
    elsif check == "looser"
        puts "\r\n#{name.capitalize}, Better Luck Next Time... You Lost."
        puts "The Word Was: #{word.upcase}"
        game_over = true
    end
end