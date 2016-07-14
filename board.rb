require './tile'

class Board
  attr_reader :grid

  def initialize(rows = 9, cols = 9, mines_count = 10)
    @rows_cnt = rows
    @cols_cnt = cols
    @grid = Array.new(cols) { Array.new(rows) }
    @mines_count = mines_count
  end

  def [](row, col)
    @grid[row][col]
  end

  def []=(row, col, tile)
    @grid[row][col] = tile
  end

  def populate
    (0...@rows_cnt).each do |row|
      (0...@cols_cnt).each do |col|
        self[row, col] = Tile.new
      end
    end
    place_mines
  end

  def place_mines
    mines_placed = 0
    until mines_placed == @mines_count
      rand_row = rand(0...@rows_cnt)
      rand_col = rand(0...@cols_cnt)
      next if self[rand_row, rand_col].mine == true
      self[rand_row, rand_col].mine = true
      mines_placed += 1
    end
  end

  def assign_neighbors

  end

  def render
    print " "
    (0...@cols_cnt).each { |col_idx| print "  #{col_idx}" }
    print "\n"
    (0...@rows_cnt).each do |row_idx|
      print "#{row_idx}"
      display_row(row_idx)
      print "\n"
    end
  end

  def display_row(row_idx)
    @grid[row_idx].each { |tile| print "  #{tile.display}"}
  end
end


if __FILE__ == $PROGRAM_NAME
  board = Board.new
  board.populate
  board.render
end
