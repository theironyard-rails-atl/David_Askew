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

