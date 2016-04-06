module Scrabble
  class Scoring
    LETTER_SCORES = {"a"=>1, "b"=>3, "c"=>3, "d"=>2, "e"=>1, "f"=>4, "g"=>2,
      "h"=>4, "i"=>1, "j"=>8, "k"=>5, "l"=>1, "m"=>3, "n"=>1, "o"=>1, "p"=>3,
      "q"=>10, "r"=>1, "s"=>1, "t"=>1, "u"=>1, "v"=>4, "w"=>4, "x"=>8, "y"=>4,
      "z"=>10}


      def self.score(word) # takes a string
        return 0 if word.empty? # empty string/pass

        score = 0

        #Add bonus for word_length corner case.
        score = 50 if word.length == Scrabble::MAXIMUM_NUMBER_OF_LETTERS

        split_word = word.downcase.split('') # downcase for comparing

        split_word.each do |letter|
          score += LETTER_SCORES[letter]
        end

        return score
      end

      def self.highest_score_from(array_of_words)

        score_array = array_of_words.collect { |word| self.score(word) }

        number_of_highest_scores =  self.get_number_of_duplicates(score_array.sort.reverse)
        # sort gives ascending
        # reverse for descending to compare HIGHEST scores

        highest_scoring_words  = array_of_words.max_by(number_of_highest_scores) {  |word| self.score(word) }

        return highest_scoring_words[0].to_s if highest_scoring_words.length == 1

        words_by_length = highest_scoring_words.min_by(number_of_highest_scores) {  |word| word.length }
        #shortest first - sorting WORDS by length (to analyze ties)

        lengths_of_words = words_by_length.collect { |word| word.length }

        if lengths_of_words.last == MAXIMUM_NUMBER_OF_LETTERS
          if self.has_duplicates?(lengths_of_words.reverse) # reverse to change   ascending to descending because WORD_LENGTH_MAXIMUM is the longest we   expect
            winning_word =  self.get_first_word_for_length_and_score(lengths_of_words.reverse,  words_by_length, array_of_words)
            return winning_word
          end

          return words_by_length.last

        elsif self.has_duplicates?(lengths_of_words) # we do want this in ascending   order because normally smaller words win (based on rules)
          winning_word = self.get_first_word_for_length_and_score(lengths_of_words,   words_by_length, array_of_words)
          return winning_word
        else
          words_by_length.first
        end
      end

      def self.has_duplicates?(array_of_words)
        self.get_number_of_duplicates(array_of_words) > 1 ? true : false
      end

      def self.get_first_word_for_length_and_score(array_of_equal_lengths,  high_scores_array, original_array)

        number_of_ties_same_length =  self.get_number_of_duplicates(array_of_equal_lengths)
        potential_winners = high_scores_array.first(number_of_ties_same_length)
        winning_word = original_array.find { |word| potential_winners.include? word   }
        return winning_word
      end

      def self.get_number_of_duplicates(array_of_words)
        i = 1
        array_of_words_x = array_of_words.dup # prevents mutation of array_of_words   from shift
        while (array_of_words_x[0] == array_of_words_x[1]) &&   (array_of_words_x.length > 1)
          array_of_words_x.shift
          i +=1
        end
        return i
      end

  end
end
