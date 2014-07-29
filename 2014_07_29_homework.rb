
=begin
* Get Ruby koans running. Do as many as you can / need to.
* Watch this video on pry and follow along - http://vimeo.com/26391171
* Share any beginner resources that you've used and found helpful on Basecamp
=end
=begin
1. Update your bash prompt (using `export PS1=...`) to at least include
   the present working directory (\d). See [mine](https://github.com/jamesdabbs/tiy-ror/blob/master/dotfiles/.bash_profile#L22)
   for a reference.
   * Bonus - go nuts. Some ideas: include a timestamp, display a red x if the
     last command failed, include the number of files in the current
     directory, show what git branch you're on.

# Name the colors we'll be using to make them somewhat readable
ORANGE="\[\e[38;5;214m\]"
YELLOW="\[\e[38;5;228m\]"
CYAN="\[\e[0;36m\]"

BLDGRN='\e[1;32m' # Green - Bold
BLDRED='\e[1;31m' # Red - Bold

WHITE="\[\e[1;37m\]"
LIGHT="\[\e[0;37m\]"
DARK="\[\e[38;5;240m\]"

# Set the prompt
# \u - user
# \h - host
# \w - working directory



function lastc() {

  if [ $? -ne 0 ]; then
    export PS1="${BLDRED} ${ERR_PROMPT}X ${LIGHT}: ${ORANGE}\u ${DARK}@ ${YELLOW}\h ${DARK}in ${CYAN}\w ${LIGHT}\$ "
  else
    export PS1="${BLDGRN} \342\234\223 ${LIGHT}: ${ORANGE}\u ${DARK}@ ${YELLOW}\h ${DARK}in ${CYAN}\w ${LIGHT}\$ "
  fi

}

PROMPT_COMMAND=lastc

=end


=begin

2.
  * Write a method `grade` that takes in a numerical grade 1-100 and
     prints out the letter version of it.
  * Write a function that produces an array of random scores:
     `students(5) = [88, 93, 91, 73, 97]`
  * Compute the grades for a class of 25 students. Write a function to
    determine how many A's there were.
=end

def grade(param=0)

  g = param.to_i

  return "A" if g >= 90           
  return "B" if g.between?(80,89) 
  return "C" if g.between?(70,79) 
  return "D" if g.between?(60,69) 
  return "F" if g.between?(00,59)

end

puts grade
puts grade(90)
puts grade(80)
puts grade(70)
puts grade(60)
puts grade(50)

puts "--------"

# Take 1
def students(num=0)
  result = []
  num.times { result << Random.rand(100) + 1}
  return result
end

puts students(5)

puts "--------"

# Take 2
def students2(num=0)
  return Array.new(num).map { |i| i = Random.rand(100) + 1 }
end

puts students2(5)

puts "--------"

def grade_count(students=students2(25), _grade="A")
  return students.count {|x| grade(x) == _grade}
end

puts grade_count([1,2,90,91,1,89])

puts "---------"

=begin
3. Write a number guessing game
  * The computer should pick a random number
  * The player guesses, and the computer says if the guess is high or low
  * Play proceeds until the player gets the number or runs out of guesses
  Bonus: reverse the game (so the player chooses and the computer guesses). What's
    the best strategy for the computer? Can you define others?
=end

cpick = Random.rand(100) + 1

win = false
quit = false

guess_count = 0

while !win && !quit
  puts = "Pick a number between 1 and 100 or type 'quit' if you give up"
  print "Guess:"

  guess_raw = gets.chomp

  quit = true  if guess_raw == "quit"

  next if quit == true
  next if guess_raw.to_i == 0

  guess_count += 1
  guess = guess_raw.to_i

  win = true if guess == cpick
  
  next if win == true

  puts "Guess is too high" if guess > cpick
  puts "Guess is too low"  if guess < cpick

end

puts "You won in #{guess_count} guesses!" if win
puts "Quiter!"  if quit

=begin
4. Write a shopping cart class that stores any number of items
   * Users should be able to add and remove items from the cart
   * The cart should be able to compute the total checkout price, after applying tax
   * Shoppers get a 10% discout if they spend more than $100 (before tax)
=end

class Item

  attr_reader :name, :price

  def initialize(_name="Unknown",_price=0.0)
    @name  = _name
    @price = _price
  end

end

class ShoppingCart

  attr_reader :list

  def initialize
    @list = []
  end

  public

  def addItem(_item)
    @list << _item
  end

  def removeItem(_item)
    @list.delete_if {|i| i == _item }
  end

  def checkoutPrice(tax_rate=0.07)
    total = 0.0
    @list.each {|i| total += i.price}
    #return total*(1 + tax_rate) if total <= 100
    #return total*0.90*(1 + tax_rate) if total > 100
    if(total <= 100)
        return total * (1 + tax_rate) 
    else
        return total * 0.90 * (1 + tax_rate)
    end

  end

end

a = Item.new("Test 1", 1.00)
b = Item.new("Test 2", 2.00)
sc = ShoppingCart.new
sc.addItem(a)
sc.removeItem(a)
sc.addItem(b)

puts sc.list.length

puts sc.checkoutPrice

=begin
5. Design a hangman game.
  * Write out everything that the game should do
  * Bonus - (start to) code it up
=end

#  Hangman should:
#	- generate a random phrase
#       - display game state to user .. including board state and  word state
#       - prompt the user to play
#       - get the guess from the player
#       - check if word contains player's guess
#       - if no, hang the user more
#	- loop until a win is established or you have hung yourself / run out of turns

