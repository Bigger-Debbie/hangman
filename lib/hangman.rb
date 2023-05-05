require_relative 'random_word.rb'
require_relative 'display.rb'

word = RandomWord.pick_random
dispaly = Display.new(word)