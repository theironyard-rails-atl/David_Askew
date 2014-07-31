require "./survey"

puts ""
the_survey = Survey.new
the_survey.statements.each do |statement|
    answer_recorded = false
    while(!answer_recorded)
        puts "Statement: #{statement}"
        print "Response > "
        answer = gets.chomp
        puts ""
        answer_recorded = the_survey.respond(answer)
    end
end

puts ""
puts "The average rating is #{the_survey.average_rating}."
puts "The lowest rating is #{the_survey.lowest_rating}."
puts "The highest rating is #{the_survey.highest_rating}."
puts ""
