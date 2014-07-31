
class WordGame
  
  attr_reader :tries_left

  def initialize(_word=nil,_max_guesses=9)
    @word = _word || ["Example","Words","Only","Dictionary"]

    @tries_left = _max_guesses 

    @previous_guesses = [] 
    @remaining_letters = @word.split(//) 
  end

  def guess(_word_or_char)
    
    @last_guess = _word_or_char

    @tries_left -= 1  
    @previous_guesses << _word_or_char

    @remaining_letters.delete(_word_or_char)
  end

  def won?
    @word.downcase == @last_guess.downcase || @remaining_letters.size == 0
  end

  def finished?
    won? || @tries_left == 0
  end

end
