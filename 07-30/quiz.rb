require 'pry'

the_question = {
  :question => "Why did the chicken cross the road?",
  :choices => [
    "First choice",
    "Right Answer",
    "Other wrong answer"
  ],
  :answer => 1
}

the_other_question = {
  :question => "Wat?",
  :choices => [
    "Yes",
    "No",
    "Maybe?"
  ],
  :answer => 2
}

the_third_question = {
  :question => "Why did I add a third question?",
  :choices  => [
     "I'm not good at counting",
     "I like torture",
     "I just felt like it"
  ],
  :answer => 3
}

questions_list = [ the_question, the_other_question, the_third_question]

#Then running ruby quiz.rb should display the questions one at a time in random order, ask the user for input, and display their score when done. Bonus: display which questions the user got right / wrong with answers at the end.

score = 0

questions_you_got_right = []
questions_you_got_wrong = []

puts ""
puts "Welcome to my quiz game!"
puts ""

while(questions_list.size > 0)
  next_question = questions_list.sample
  questions_list.delete_if { |item| item == next_question}
  puts  "Q: " + next_question[:question]
  puts  ""
  puts  "Possible Answers:"
  puts  next_question[:choices]
  puts  ""
  print "A: "
  user_answer = gets.chomp
  puts ""
  answer_index = next_question[:answer]
  correct_answer = next_question[:choices][answer_index - 1] 
  
  if correct_answer.downcase == user_answer.downcase
    score = score + 1 
    questions_you_got_right << next_question
  else
    questions_you_got_wrong << next_question
  end
end

puts ""
puts "Your final score is #{score}"
puts ""

print "Would you like to review your questions? (Yes or No) > "
review_response = gets.chomp

if review_response.downcase == "yes"
  puts ""  
  puts "Questions you got right:" if questions_you_got_right.size > 0
  puts questions_you_got_right
  puts ""
  puts "Quesions you got wrong:" if questions_you_got_wrong.size > 0
  puts questions_you_got_wrong

else
  puts "Ok. Goodbye!"
end
#binding.pry
