require 'minitest/autorun'

require './2048'

describe Board do
  it "has a grid" do
    b = Board.new
    assert_instance_of Array, b.grid
  end
end

describe AsciiBoard do
  it "has a grid" do
    b = AsciiBoard.new
    assert_instance_of Array, b.grid
  end
  it "can be displayed" do
    assert_respond_to(AsciiBoard.new, :display_board)
  end

  it "has a grid of 14 zeros and 2 non-zeros by default when started" do
    ab = AsciiBoard.new
    assert_equal 14, ab.grid.count(0)
    assert_equal  2, ab.grid.count - ab.grid.count(0)
  end

  it "is not full when the game starts" do
     ab = AsciiBoard.new
     assert_equal false, ab.full?
  end

  it "is not empty by default when the board is created" do
    ab = AsciiBoard.new
    assert_respond_to(ab, :empty?)
    assert_equal false, ab.empty?
  end

  it "throws an error when created with a starting grid larger than 16" do
    assert_raises(InvalidBoardException) do
      sample_grid = []
      17.times do
        sample_grid << 0
      end
      ab = AsciiBoard.new(sample_grid)
    end
  end

  it "throws an error when created with a starting grid between 1 and 15" do
    assert_raises(InvalidBoardException) { ab = AsciiBoard.new([0,0,0,0,0]) }
  end

  it "can be empty" do
    ab = AsciiBoard.new()
    assert_respond_to(ab, :empty?)
  end

  it "can be blank" do
    ab = AsciiBoard.new(Array.new(0))
    assert_respond_to(ab, :blank?)
    assert_equal true, ab.blank?
    ab2 = AsciiBoard.new([0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0])
    assert_equal false, ab2.blank?
  end

  it "can be shifted" do
    ab = AsciiBoard.new
    assert_respond_to(ab, :shift)
    #assert_raises(InvalidShiftException, { ab.shift("foobar") }
    #assert_raises(InvalidShiftException, { ab.shift(1) }
  end

  it "is full when the grid has sixteen non-zero values" do
    ab = AsciiBoard.new([2,4,8,16,32,64,128,256,512,1024,2048,1024,512,256,128,64])
    assert_equal true, ab.full?
    ab2 = AsciiBoard.new([2,4,8,16,32,64,128,256,512,1024,0,1024,512,256,128,64])
    assert_equal false, ab2.full?
  end

  it "has an internal record of the number of open spaces" do
    ab = AsciiBoard.new
    assert_respond_to(ab, :remaining_spaces)
  end

  it "has 14 remaining spaces when the game starts" do
    ab = AsciiBoard.new
    assert_equal 14, ab.remaining_spaces
  end

  it "can only be shifted left, right, up, and down" do
    ab = AsciiBoard.new
    assert_equal ab.shifts_allowed, [:left,:right,:up, :down]
  end

  it "can be shifted left" do
    starting_grid = [0,0,0,0,0,0,2,0,4,0,0,0,0,0,0,0]
    ab = AsciiBoard.new(starting_grid)
    assert_equal starting_grid, ab.grid
    #assert_equal true, ab.valid_plays?
    assert_raises(InvalidShiftException) { ab.shift("foobar") }
    assert_raises(InvalidShiftException) { ab.shift(:diagonal) }
    assert_equal true, ab.shift(:left)
    assert_equal 2, ab.grid[4]
    assert_equal 4, ab.grid[8]
    #puts "here #{ab.grid}"
    assert_equal 13, ab.remaining_spaces

    starting_grid = [0,0,0,0,0,0,2,2,4,0,0,4,0,0,0,0]
    ab = AsciiBoard.new(starting_grid)
    assert_equal starting_grid, ab.grid
    assert_equal 12, ab.remaining_spaces
    assert_equal true, ab.shift(:left)
    assert_equal 4, ab.grid[4]
    assert_equal 8, ab.grid[8]
    assert_equal 13, ab.remaining_spaces

    starting_grid = [0,0,0,0,0,2,2,2,4,0,4,4,0,0,0,0]
    ab = AsciiBoard.new(starting_grid)
    assert_equal starting_grid, ab.grid
    assert_equal 10, ab.remaining_spaces
    assert_equal true, ab.shift(:left)
    assert_equal 4, ab.grid[4]
    assert_equal 2, ab.grid[5]
    assert_equal 8, ab.grid[8]
    assert_equal 4, ab.grid[9]
    assert_equal 11, ab.remaining_spaces

    starting_grid = [0,0,0,0,2,2,2,2,4,4,4,4,0,0,0,0]
    ab = AsciiBoard.new(starting_grid)
    assert_equal starting_grid, ab.grid
    puts ""
    puts "here 1 #{ab.grid}"
    assert_equal 8, ab.remaining_spaces
    assert_equal true, ab.shift(:left)
    assert_equal 4, ab.grid[4]
    assert_equal 4, ab.grid[5]
    assert_equal 8, ab.grid[8]
    assert_equal 8, ab.grid[9]
    puts ""
    puts "here 2 #{ab.grid}"
    assert_equal 11, ab.remaining_spaces

  end

  it "can be shifted right"

  it "can be shifted up"

  it "can be shifted down"

  it "has no valid plays when there are none"

end

describe Player do
  it "has a name" do
    p1 = Player.new("David")
    assert_equal "David", p1.name
  end
end

describe Game do
  it "must be created with an initial Player" do
    assert_raises(NoPlayerException) { game = Game.new("David") }
  end

  it "has one player" do
    p1 = Player.new("David")
    game = Game.new(p1)
    assert_instance_of Player, game.player
  end

  it "has a board" do
    p1 = Player.new("David")
    game = Game.new(p1)
    assert_instance_of Board, game.board
  end

  it "has a score of 0 when it is started" do
   game = Game.new(Player.new("David"))
   assert_equal 0, game.score
  end

  it "can be quit by the player" do
    game = Game.new(Player.new("David"))
    assert_respond_to(game,:quit)
    game.quit
    assert_equal true, game.finished?
  end

  it "is not finished when it starts" do
    game = Game.new(Player.new("David"))
    assert_equal false, game.finished?
  end
end

describe AsciiGame do
  it "is a Game" do
    assert_kind_of Game, AsciiGame.new(Player.new("David"))
  end
  it "has one player" do
    game = AsciiGame.new(Player.new("David"))
    assert_instance_of Player, game.player
  end
  it "has a board" do
    game = AsciiGame.new(Player.new("David"))
    assert_instance_of AsciiBoard, game.board
  end

  it "is not finished when game starts" do
    game = AsciiGame.new(Player.new("David"))
    assert_equal false, game.finished?
  end

  it "has valid plays when the game starts" do
    game = AsciiGame.new(Player.new("David"))
    assert true, game.board.valid_plays?
  end

  it "is finished when its board is full and has no more valid plays"

  it "is finished when the player quits" do
    game = AsciiGame.new(Player.new("David"))
    game.quit
    assert_equal true, game.finished?
  end

end

