class RandomWord
    def initilize
        @word = pick_random
    end
    
    def pick_random
        words = File.read(../google-10000-english-no-swears.txt)
        filtered_words = Array.new

        words.each do |word|
            if word.lenth.between?(5, 12)
                filtered_words.push(word)
            end
        end

        return filtered_words.sample
    end
end