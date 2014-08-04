require './blackjack'

deck = Deck.new
dealer = Dealer.new("Elvis")
player = Player.new("David",100)
game_choice = "" 

until game_choice == "quit" do
    puts ""
    puts "Hello #{player.name}!"
    print "Would you like to play or quit? > "
    game_choice = gets.chomp
    puts ""    
    if (game_choice == "play")
        wager = 0
        puts "Ok Then, Place your bet!"
        until wager <= player.stack_value && wager > 0 do
            print "You have #{player.stack_value}.  How much to wager? > "
            wager = gets.chomp.to_i
            if(player.stack_value >= wager) && (wager > 0)
                    puts "Great, lets play!"
                    player.bet(wager)
                    the_game = Game.new(dealer,player)
                    the_deck = Deck.new
                    the_game.dealer.shuffle!(the_deck)
                    the_hand = Hand.new(the_game.dealer.deal(2,the_deck))
                    player.take_cards!(the_hand)
                    dealer_hand = Hand.new(the_game.dealer.deal(2,the_deck))
                    choice = ""
                    result = ""
                    
                    result = "Lose" if dealer_hand.total_value == 21

                    until choice == "Stand" || result == "Bust" or result == "Lose" do
                        puts "The dealer is showing #{dealer_hand.cards[0].to_s}"
                        puts "You have a #{player.hand.to_s}."
                        if(Game.busted_hand?(player.hand))
                            result = "Bust"
                            puts "Sorry, you busted.  The House wins!"
                            break;
                        end
                        #require 'pry'
                        #binding.pry
                        print "Hit or Stand? > "
                        choice = gets.chomp
                        if choice == "Hit"
                            new_card = the_game.dealer.deal(1,the_deck)[0]
                            player.hand.add(new_card)
                        elsif choice == "Stand"
                            puts "Very well.  The dealer has #{dealer_hand.to_s}."
                            until !Game.dealer_hits?(dealer_hand) || Game.busted_hand?(dealer_hand)
                                next_card = the_game.dealer.deal(1,the_deck)[0] 
                                dealer_hand.add(next_card)
                                puts "The dealer took a card."
                                puts "The dealer is showing #{dealer_hand.to_s}" 
                            end

                            dealer_final = dealer_hand.total_value - (10*dealer_hand.ace_count)
                            player_final = player.hand.total_value - (10*player.hand.ace_count)
                            if Game.busted_hand?(dealer_hand) 
                                result = "Win"
                                puts"The deal busted.  You win!!!"
                                player.receive(the_game.dealer.pay(wager*2))
                            elsif dealer_final == player_final
                                result = "Tie"
                                puts "You tied."
                            elsif dealer_final > player_final
                                result = "Loss"
                                puts "You lost."
                            elsif player_final > dealer_final
                                result = "Win"
                                puts "You win!!"
                                player.receive(the_game.dealer.pay(wager*2))
                            end
                        else
                            puts "I don't understand #{choice}!"
                        end
                    end
            else
                if(wager == 0)
                    puts "You must wager at least 1 dollar"
                end
            end
        end
    elsif (game_choice == "quit")
        puts "Quiter!"
    else
        puts "I don't understand"
    end
   
end

