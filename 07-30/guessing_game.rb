class GuessingGame
  # Make guess
  # - determines if we won
  # - respond with high / low
  # Keep track of number of guesses
  # - fail the game if we've run out
  attr_reader :tries_left # attr_writer, attr_accessor

  def initialize(answer=nil, max_tries=nil)
    @answer = if answer
      answer
    else
      (0..100).to_a.sample
    end

    # Alternative
    # @answer   = answer
    # @answer ||= (0..100).to_a.sample

    # Or
    # @answer = answer || (0..100).to_a.sample


    
    @tries_left = if max_tries
      max_tries
    else
      5
    end

    @won = false

  end

  def guess(number)
    @tries_left -= 1

    if number == @answer
      @won = true
    elsif number < @answer
      "Your guess is too low"
    else
      "Your guess is too high"
    end
  end

  def finished?
    @tries_left.zero? || @won
  end

  def won?
    @won
  end

  # Using attr_reader instead
  #def tries_left
  #  @tries_left
  #end
end
