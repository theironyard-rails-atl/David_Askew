=begin
### 1. Survey

Write a questionnaire that takes a list of statements,
and asks the user to rate how strongly they agree with
the statement (on a scale of 1 to 5).

Level 1:
  After the survey is over, print out the user's highest,
  lowest, and average rating.

Level 2:
  Write a Survey class and have an external script to
  drive the user interaction.

Level 3:
  Write tests for your Survey class.
=end

class Survey

    attr_reader :statements, :responses

    def initialize
        @statements =  [ "You like the way David has implemented this.",
                         "The way David thinks is usually correct.",
                         "David is never wrong." ]
        @responses = []
    end

    def respond(number_rating)
        rating = number_rating.to_i
        if(rating > 0)
            responses << rating
            true
        else
            false
        end
    end

    def complete?
        @statements.size == @responses.size
    end

    def average_rating
        (@responses.inject('+').to_f/@responses.size.to_f).round(2)
    end
    
    def lowest_rating 
        @responses.min
    end

    def highest_rating
        @responses.max
    end

end
