=begin

### 2. Blackjack

Write a script to play blackjack.

Level 1:
* The program should be fully object-oriented
* The player starts with $100 and bets are $10
* The only options are hit and stand
* Players can play as long as they can afford it, and can
  leave after any round.
* The dealer reshuffles after every round
* The included test file should pass (defining Card, Deck, and Hand)
* Push your homework up to your repository on github

Level 1.5:
* Add graphics to your script: https://github.com/jdan/rubycards

Level 2:
* Ignore the included spec file, and test drive development yourself
* Write specs for any other classes you use (Player? Game?)

Level 3:
* Allow variable bets
* Allow double-downs
* Dealer only reshuffles when the deck runs out
  * Allow for multiple decks

=end
class Card

    HEART   = :HEART
    SPADE   = :SPADE
    DIAMOND = :DIAMOND
    CLUB    = :CLUB

    attr_reader :suit, :face_value 

    def initialize(_face_value,_suit)
        @suit = _suit 
        @face_value = _face_value
    end

    def value
        case @face_value
        when "A"
            11
        when "K","Q","J","10"
            10
        when (2..9)
            @face_value
        end
    end

    def rank
        case @face_value
        when (2..10)
            @face_value
        when "J"
            11
        when "Q"
            12
        when "K"
            13
        when "A"
            14
        end
    end

end

class Hand

    attr_reader :cards

    def initialize(_cards_array)
        @cards = _cards_array
    end

    def add(new_card)
        @cards << new_card
    end

    def remove(card_to_remove)
        @cards.delete_if { |card| card == card_to_remove}
    end

end

class Deck
    
    attr_accessor :deck

    def initialize
        @deck = build_deck 
    end

    private

    def build_deck
       temp_deck = []
       [Card::HEART, Card::DIAMOND, Card::CLUB, Card::SPADE].each do |suit|
            (2..10).each do |num|
                temp_deck << Card.new(num,suit)
            end 
            ["A","K","Q","J"].each do |face_card|
                temp_deck << Card.new(face_card,suit)
            end
       end 
       temp_deck
    end

end

class Player

    attr_reader :name, :stack_value

    def initialize(_name="Unknown",_initial_money=0)
        @name = _name
        @stack_value = _initial_money
    end

    def bet(_amount)
        unless @stack_value < _amount
            @stack_value -= _amount
            true
        else
           false
        end        
    end

    def receive(_amount)
        @stack_value += _amount
        true
    end
end

class Dealer

    attr_reader :name

    def initialize(_name="Dealer")
        @name = _name
    end

    def pay(amount_to_pay)
       amount_to_pay
    end

    def shuffle!(deck_to_shuffle)
        deck_to_shuffle.deck.shuffle!
    end

    def deal(number_of_cards, the_deck)
        cards_dealt = []
        number_of_cards.times do
            cards_dealt << the_deck.deck.pop
        end
        cards_dealt
    end
end
