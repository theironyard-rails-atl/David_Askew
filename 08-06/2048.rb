class Board
  attr_reader :grid, :shifts_allowed

  def initialize(_grid = [])
      @grid ||= []
      @shifts_allowed = [:left,:right,:up,:down]
  end

  def display_board
    @grid
  end

end

class InvalidBoardException < StandardError; end
class InvalidShiftException < StandardError; end

class AsciiBoard < Board
  def initialize(_grid=Array.new(16,0))
    @grid = _grid #Array.new(16,0)

    raise InvalidBoardException if @grid.size > 16
    raise InvalidBoardException if @grid.size.between?(1,15)

    if empty?
      first_num = Random.rand(16) #+ 1

      @grid[first_num] = 2

      if(first_num > 9)
        second_num = first_num - 5
      else
        second_num = first_num + 5
      end

      @grid[second_num] = 4

    end

    super

  end

  def full?
   return false if  @grid.include? 0
   return true  if !@grid.include? 0
  end

  def empty?
    return true if @grid.count(0) == 16
    return false
  end

  def blank?
    return true if @grid.size == 0
    return false
  end

  def valid_plays?
    return true if !full?
  end

  def remaining_spaces
    return @grid.count(0)
  end

  def add_random
    if !full?
      indexes_of_zero = []
      @grid.each_index do |index|
        indexes_of_zero << index if @grid[index] == 0
      end
      @grid[indexes_of_zero.sample] = [2,4].sample
    end
  end

  def shift(direction)
    raise InvalidShiftException if !shifts_allowed.include?(direction)
    new_grid = @grid.clone

    if direction == :left
      row1 = new_grid.slice(0,4)
      row2 = new_grid.slice(4,4)
      row3 = new_grid.slice(8,4)
      row4 = new_grid.slice(12,4)
      rows = [row1,row2,row3,row4]
      rows.each do |row|
        if row.count(0) == 3
          row[0] = row.max
          row[1] = 0
          row[2] = 0
          row[3] = 0
        elsif(row.count(0) == 2)
          new_row = row.select { |num| num > 0 }
          if(new_row[0] == new_row[1])
            row[0] = new_row[0] + new_row[1]
            row[1] = 0
            row[2] = 0
            row[3] = 0
          else
            row[0] = new_row[0]
            row[1] = new_row[1]
          end
        elsif(row.count(0) == 1)
          new_row = row.select { |num| num > 0 }
          if(new_row[0] == new_row[1])
            row[0] = new_row[0] + new_row[1]
            row[1] = new_row[2]
            row[2] = 0
            row[3] = 0
          elsif(new_row[1] == new_row[2])
            row[0] = new_row[0]
            row[1] = new_row[1] + new_row[2]
            row[2] = 0
            row[3] = 0
          else
            row[0] = new_row[0]
            row[1] = new_row[1]
            row[2] = new_row[2]
            row[3] = 0
          end
        elsif(row.count(0) == 0)
          new_row = row.select { |num| num > 0 }
          if(new_row[0]==new_row[1])
            row[0] = new_row[0] + new_row[1]
            if(new_row[2] == new_row[3])
               row[1] = new_row[2] + new_row[3]
               row[2] = 0
               row[3] = 0
            else
               row[1] = new_row[2]
               row[2] = new_row[3]
               row[3] = 0
            end
          elsif(new_row[1]==new_row[2])
            row[0] = new_row[0]
            row[1] = new_row[1] + new_row[2]
            row[2] = new_row[3]
            row[3] = 0
          elsif(new_row[2]==new_row[3])
            row[0] = new_row[0]
            row[1] = new_row[0]
            row[2] = new_row[2] + new_row[3]
            row[3] = 0
          end
        end
      end
      new_grid = row1 + row2 + row3 + row4
    end

    if new_grid != @grid
      @grid = new_grid
      add_random
      return true
    else
      return false
    end

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
