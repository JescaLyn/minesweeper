require_relative 'tile'
require 'byebug'

class Board
  NEIGHBORS = [
    [1, 0],
    [1, 1],
    [1, -1],
    [-1, 0],
    [-1, 1],
    [-1, -1],
    [0, 1],
    [0, -1]
    ]

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
    assign_neighbor_bmbs
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

  def assign_neighbor_bmbs
    (0...@rows_cnt).each do |row|
      (0...@cols_cnt).each do |col|
        if self[row, col].mine == true
          add_to_neighbor_count([row, col])
        end
      end
    end
  end

  def add_to_neighbor_count(pos)
    neighbors(pos).each { |neighbor| self[*neighbor].neighbor_bmbs += 1 }
  end

  def neighbors(pos)
    NEIGHBORS.map do |adj|
      [adj[0] + pos[0], adj[1] + pos[1]]
    end.select { |neighbor| valid_pos?(neighbor) }
  end

  def valid_pos?(pos)
    row, col = pos
    row.between?(0, @rows_cnt - 1) && col.between?(0, @cols_cnt - 1)
  end

  def explore_tiles(pos)
    self[*pos].revealed = true
    if self[*pos].neighbor_bmbs == 0
      neighbors(pos).each do |neighbor|
        explore_tiles(neighbor) if self[*neighbor].revealed == false
      end
    end
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
