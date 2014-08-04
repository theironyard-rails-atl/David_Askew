require "./survey"

puts ""
the_survey = Survey.new("./more_than_3_questions.yml")
the_survey.statements.each do |statement|
    begin
        puts "Statement: #{statement.text}"
        print "Response > "
        answer = gets.chomp
        puts ""
        answer_recorded = the_survey.respond(answer)
    end while answer_recorded == false
end

puts ""
puts "The average rating is #{the_survey.average_rating}."
puts "The lowest rating is #{the_survey.lowest_rating}."
puts "The highest rating is #{the_survey.highest_rating}."
puts ""
