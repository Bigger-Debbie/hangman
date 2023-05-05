class RandomWord
    def self.pick_random
        words = File.readlines('../google-10000-english-no-swears.txt')
        filtered_words = Array.new

        words.each do |word|
            if word.strip.length.between?(5, 12)
                filtered_words.push(word.strip)
            end
        end

        return filtered_words.sample
    end
end