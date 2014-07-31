require "minitest/autorun"

require "./wordgame"
require "pry"

describe WordGame do

  it "Can be won by guessing the correct word" do
    game = WordGame.new("word")
    game.guess("word")
    assert_equal true, game.won?
  end

  it "Can be won by guessing the last letter correctly" do
    game = WordGame.new("word")
    game.guess("w")
    game.guess("o")
    game.guess("r")
    game.guess("d")
    assert_equal true, game.finished?
    assert_equal true, game.won?
  end

  it "Ends after 9 incorrect guesses" do
    game = WordGame.new("wordyderd")
    game.guess("a")
    game.guess("b")
    game.guess("c")
    game.guess("f")
    game.guess("g")
    game.guess("hfoo")
    game.guess("i")
    game.guess("j")
    game.guess("k")
    assert_equal true, game.finished?
    assert_equal false, game.won?
  end

  it "Considers upper and lowercase guesses the same" do
    game = WordGame.new("word")
    game.guess("WORD")
    assert_equal true, game.won?
  end 

  it "Counts an incorrect guess wrong twice if played twice" 

end
