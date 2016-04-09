class ScrabbleMultiple
  LETTER_SCORES = {"a"=>1, "b"=>3, "c"=>3, "d"=>2, "e"=>1, "f"=>4, "g"=>2,
    "h"=>4, "i"=>1, "j"=>8, "k"=>5, "l"=>1, "m"=>3, "n"=>1, "o"=>1, "p"=>3,
    "q"=>10, "r"=>1, "s"=>1, "t"=>1, "u"=>1, "v"=>4, "w"=>4, "x"=>8, "y"=>4,
    "z"=>10}
  BONUS_NUMBER_OF_LETTERS = 7

  attr_reader :bonus

  def initialize(words_array, bonus)
  @words = words_array
  @bonus = bonus
  end

  def score_many(words = @words)
    scores = words.collect do |word|
      score(word)
    end
  end

  def points_many_words(words = @words)
    words_collection = {}
    letter_points = words.each do |word|
      words_collection[word] = points_by_letter(word)
    end
    return words_collection
  end

  def score(word) # takes a string
    return 0 if word.empty? # empty string/pass

    score = 0

    #Add bonus for word_length corner case.
    score = 50 if (bonus == "true" && word.length == BONUS_NUMBER_OF_LETTERS)

    split_word = word.downcase.split('') # downcase for comparing

    split_word.each do |letter|
      score += LETTER_SCORES[letter]
    end

    return score
  end

  def points_by_letter(word)
    return 0 if word.empty?

    split_word = word.downcase.split('') # downcase for comparing

    letter_points = split_word.collect do |letter|
      LETTER_SCORES[letter]
    end

    return split_word.zip(letter_points)

  end

end
