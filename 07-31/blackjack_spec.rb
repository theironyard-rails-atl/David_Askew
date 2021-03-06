require 'minitest/autorun'

require './blackjack'

describe "Card" do

    it "has a suit and a value" do
        card1 = Card.new("A", Card::HEART)
        assert_equal Card::HEART, card1.suit
        assert_equal 11, card1.value
    end
  
    it "has a rank between 2 and 14" do
        card1 = Card.new(2, Card::CLUB)
        card2 = Card.new("A", Card::HEART)
        assert_equal  2, card1.rank
        assert_equal 14, card2.rank
    end

    it "has a string version" do
        card1 = Card.new(2, Card::CLUB)
        assert_equal "2 of Clubs", card1.to_s
    end
end

describe "Hand" do
    it "has 1 or more cards" do
        the_cards = []
        the_cards << Card.new("A", Card::HEART) 
        the_hand = Hand.new(the_cards)
        assert_equal 1, the_hand.cards.size
    end

    it "can add a card" do
        initial_cards = []
        initial_cards << Card.new("A", Card::DIAMOND)
        initial_cards << Card.new("2", Card::HEART)
        the_hand = Hand.new(initial_cards)
        new_card = Card.new("9", Card::SPADE)
        the_hand.add(new_card)
        assert_equal 3,the_hand.cards.size        
    end

    it "can remove a card" do
        initial_cards = []
        initial_cards << Card.new("A", Card::DIAMOND)
        initial_cards << Card.new("2", Card::HEART)
        the_hand = Hand.new(initial_cards)
        card_to_remove = the_hand.cards[1]
        the_hand.remove(card_to_remove)
        assert_equal 1, the_hand.cards.size
        assert_equal initial_cards[2], the_hand.cards[1]        
    end

    it "has a string version" do
       card1 = Card.new("A", Card::DIAMOND)
       card2 = Card.new("J", Card::HEART)
       the_hand = Hand.new([card1,card2])
       assert_equal "A of Diamonds, J of Hearts", the_hand.to_s
    end

    it "has a total value" do
       card1 = Card.new("A", Card::DIAMOND)
       card2 = Card.new("J", Card::HEART)
       the_hand = Hand.new([card1,card2])
       assert_equal 21, the_hand.total_value
    end

    it "can tell you the number of aces it has" do
        card1 = Card.new("A", Card::DIAMOND)
        card2 = Card.new("J", Card::HEART)
        the_hand = Hand.new([card1,card2])
        assert_equal 1, the_hand.ace_count 
    end

end

describe "Deck" do

    it "has 52 cards" do
        the_deck = Deck.new
        assert_equal 52, the_deck.deck.size
    end

    it "has 13 Diamonds" do
        the_deck = Deck.new
        assert_equal 13, the_deck.deck.count {|card| card.suit == Card::DIAMOND }
    end

    it "has 13 Hearts" do
        the_deck = Deck.new
        assert_equal 13, the_deck.deck.count {|card| card.suit == Card::HEART }
    end

    it "has 13 Spades" do
        the_deck = Deck.new
        assert_equal 13, the_deck.deck.count {|card| card.suit == Card::SPADE }
    end

    it "has 13 Clubs" do
        the_deck = Deck.new
        assert_equal 13, the_deck.deck.count {|card| card.suit == Card::CLUB }
    end

    it "has 4 of each face value: 2-10,J,Q,K and A" do
        the_deck = Deck.new
        [2,3,4,5,6,7,8,9,10,"J","Q","K","A"]. each do |value| 
            assert_equal 4, the_deck.deck.count {|card| card.face_value == value}
        end
    end

end

describe "Player" do
    it "has a name" do
        player1 = Player.new("George")
        assert_equal "George", player1.name 
    end

    it "has a chip stack with a value of 0 or greater" do
        player1 = Player.new("John")
        player2 = Player.new("David", 100)
        assert_equal 0, player1.stack_value
        assert_equal 100, player2.stack_value
    end

    it "can make a bet if they have enough money" do
        player1 = Player.new("Jeff", 100)
        assert_equal true, player1.bet(75)
        assert_equal false, player1.bet(50)
    end

    it "can not make a bet if they have no money" do
        player1 = Player.new("John")
        assert_equal false, player1.bet(10)
    end

    it "can recieve money from winnings or ATM or whatever" do
        player1 = Player.new("David")
        assert_equal true, player1.receive(100)
    end

    it "can take cards" do
        player1 = Player.new("David",100)
        card1 = Card.new("A",Card::HEART)
        card2 = Card.new("J",Card::SPADE)
        dealt_hand = Hand.new([card1,card2])
        player1.take_cards!(dealt_hand)
        assert_equal 2, player1.hand.cards.size
    end

end

describe "Dealer" do
    it "can deal cards from a deck" do
        new_deck = Deck.new
        the_dealer = Dealer.new("Dealer's Name")
        assert_instance_of Array, the_dealer.deal(1, new_deck)
        assert_equal 51, new_deck.deck.size
    end
    
    it "can shuffle cards in a deck" do
        the_dealer = Dealer.new("The Dealer")
        the_deck = Deck.new
        first_card_pre_shuffle = the_deck.deck[1]
        the_dealer.shuffle!(the_deck)
        assert first_card_pre_shuffle != the_deck.deck[1]
    end

    it "can pay a player" do
        the_dealer = Dealer.new("Dealer's Name")
        winning_player = Player.new("David",0)
        winning_player.receive(the_dealer.pay(50))
        assert_equal 50, winning_player.stack_value
    end


end

describe Game do
    
    it "has players" do
        the_dealer = Dealer.new("Dealer's Name")
        initial_players = [Player.new("David",100)]
        the_game = Game.new(the_dealer,initial_players)
        assert_equal 1, the_game.players.size
        assert_equal initial_players[1], the_game.players[1]
    end

    it "has a dealer" do
        the_dealer = Dealer.new("Dealer")
        initial_players = [Player.new("David",100)]
        the_game = Game.new(the_dealer,initial_players)
        assert_equal the_dealer, the_game.dealer
    end

    #it "can be played"

    it "can determine a busted hand" do
        card1 = Card.new("A", Card::DIAMOND)
        card2 = Card.new("J", Card::HEART)
        the_hand = Hand.new([card1,card2])
        assert_equal false, Game.busted_hand?(the_hand) 
        the_hand.add(Card.new(10, Card::HEART))
        assert_equal false, Game.busted_hand?(the_hand)
        the_hand.add(Card.new("A", Card::DIAMOND))
        assert_equal true, Game.busted_hand?(the_hand)
    end

    it "can determine if the dealer should play" do
        card1 = Card.new(8 , Card::DIAMOND)
        card2 = Card.new("J", Card::HEART)
        the_hand = Hand.new([card1,card2])
        assert_equal false, Game.dealer_hits?(the_hand)
        card3 = Card.new(7 , Card::DIAMOND)
        card4 = Card.new("J", Card::HEART)
        next_hand = Hand.new([card3,card4])
        assert_equal false, Game.dealer_hits?(next_hand)
        card5 = Card.new(6 , Card::DIAMOND)
        card6 = Card.new("A", Card::HEART)
        soft_17 = Hand.new([card5,card6])
        assert_equal true, Game.dealer_hits?(soft_17)
        card7 = Card.new(6 , Card::DIAMOND)
        card8 = Card.new(7 , Card::HEART)
        small_hand = Hand.new([card7,card8])
        assert_equal true, Game.dealer_hits?(small_hand)
    end

end
