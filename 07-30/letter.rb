
#Write a letter counter that takes a string and returns a hash showing how many times each letter shows up in that strings. Bonus: how many t's are in this file?

input_string = "This is the input string"

char_counts = {}

input_string.each_char do |char| 
  if char_counts.has_key?(char.to_sym)
     char_counts[char.to_sym] = char_counts[char.to_sym] + 1
  else
     char_counts[char.to_sym] = 1
  end
end

puts char_counts
