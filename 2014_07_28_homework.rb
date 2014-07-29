# Define a function to find the hypotenuse of a right triangle with side lengths a and b
def hypotenuse_right(a,b)
  return a**2 + b**2
end

h = hypotenuse_right(1,2)
puts h

# What methods do strings have that symbols don't? Describe a few. What methods do symbols have that strings don't?

## all bang (!) methods, since there is no value to update.
## less to_ methods, since there is no value to convert

# Why doesn't Fixnum.new work?

## each number is a constant and only occurs once in memory?

# Write code using methods on at least one number, string, symbol, array and hash. Make a gist from the code.
# https://gist.github.com/dhaskew/f598e642b8b4a271a20d 
x = 5 * 2

message = "The value of x is #{x}"

puts message

hash = { foo: [1,2,3] }

message2 = "The #{hash.size} values in hash are #{hash}"

puts message2

# Define Musher class such that Musher.new("+").mush(["array", "of", "strings"]) == "array + of + strings"

class Musher

  def initialize(op='+')
    @op = '+'
  end

  def mush(str=[])
    return str.join(" + ")
  end

end

puts Musher.new("+").mush(["array","of","strings"])

# Define an Averager class that can compute the average of two numbers. Bonus: any number of numbers.

class Averager
  
  def initialize
  end

  def avg(list=[])
    total = 0
    list.map { |x| total += x }
    return total/list.length
  end
 
end

puts Averager.new.avg([5,25,60])

# Write a script to read list of lines from a file and print one at random

count = File.foreach("/etc/passwd").inject(0) {|c, line| c+1}

f = File.open("/etc/passwd", "r")
random = Random.rand(count) + 1
x = 0
f.each_line do |line|
  x += 1
  puts line if x == random 
end
f.close


