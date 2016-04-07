class ScrabbleMultiple
  LETTER_SCORES = {"a"=>1, "b"=>3, "c"=>3, "d"=>2, "e"=>1, "f"=>4, "g"=>2,
    "h"=>4, "i"=>1, "j"=>8, "k"=>5, "l"=>1, "m"=>3, "n"=>1, "o"=>1, "p"=>3,
    "q"=>10, "r"=>1, "s"=>1, "t"=>1, "u"=>1, "v"=>4, "w"=>4, "x"=>8, "y"=>4,
    "z"=>10}
  BONUS_NUMBER_OF_LETTERS = 7

  def initialize(words_array)
  @words = words_array
  end

  def score_many(words = @words)
    scores = words.collect do |word|
      score(word)
    end
  end

  def score(word) # takes a string
    return 0 if word.empty? # empty string/pass

    score = 0

    #Add bonus for word_length corner case.
    score = 50 if word.length >= BONUS_NUMBER_OF_LETTERS

    split_word = word.downcase.split('') # downcase for comparing

    split_word.each do |letter|
      score += LETTER_SCORES[letter]
    end

    return score
  end

end
