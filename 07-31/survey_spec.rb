require "minitest/autorun"
require "./survey"

describe Survey do

    it "has a list of multiple statements" do
        the_survey = Survey.new
        assert the_survey.statements.size > 0
    end

    it "ends when all the statements have responses" do
        the_survey = Survey.new
        (1..the_survey.statements.size).each { |s| the_survey.respond(1) }
        assert true, the_survey.complete? 
    end

    it "allows you to add a number response" do
        the_survey = Survey.new
        assert_equal true, the_survey.respond(1)
    end

    it "only allows responses to be integers between 1 and 5 (inclusive)" do
        the_survey = Survey.new
        assert_equal true, the_survey.respond("1")
        assert_equal false, the_survey.respond("foobar")
    end

    it "tracks average rating for all statements" do
        the_survey = Survey.new
        (1..the_survey.statements.size).each { |s| the_survey.respond(1) }
        assert_equal 1, the_survey.average_rating
        second_survey = Survey.new
        second_survey.respond(3)
        second_survey.respond(2)
        second_survey.respond(3)
        assert_equal 2.67, second_survey.average_rating
    end

    it "tracks the lowest rating for all statements" do
        the_survey = Survey.new
        (2..the_survey.statements.size).each { |s| the_survey.respond(2) }
        assert_equal 2, the_survey.lowest_rating
    end

    it "tracks the highest rating for all the statements" do
        the_survey = Survey.new
        (2..the_survey.statements.size).each { |s| the_survey.respond(2) }
        assert_equal 2, the_survey.lowest_rating
    end

end
