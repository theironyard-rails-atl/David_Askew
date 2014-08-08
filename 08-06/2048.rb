class Board
  attr_reader :grid

  def initialize
      @grid ||= []
  end

  def display_board
    @grid
  end

end

class AsciiBoard < Board
  def initialize
    @grid = Array.new(16,0)

    first_num = Random.rand(16) + 1

    @grid[first_num] = 2

    if(first_num > 9)
      second_num = first_num - 5
    else
      second_num = first_num + 5
    end

    @grid[second_num] = 4

    super
  end

  def full?
   return false if  @grid.include? 0
   return true  if !@grid.include? 0
  end

  def valid_plays?
    return true if !full?
  end

  def shift(direction)

  end

end

class Player
  attr_reader :name
  def initialize(name="Unknown")
    @name = name
  end
end

class NoPlayerException < StandardError; end

class Game
  attr_reader :player, :board, :score
  def initialize(player)
    raise NoPlayerException, "Invalid argument. Player required." if !player.is_a? Player
    @player ||= player
    @board  ||= Board.new
    @score  = 0
    @player_quit = false
  end

  def quit
    @player_quit = true
  end

  def finished?
    @player_quit
  end

end

class AsciiGame < Game
  def initialize(player)
    @board = AsciiBoard.new
    super(player)
  end
  def finished?
    return false unless @board.full? || @player_quit
    return true
  end
end
