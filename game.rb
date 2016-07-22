require_relative 'board'

class Game
  def initialize(rows = 9, cols = 9, mines = 10)
    @board = Board.new(rows, cols, mines)
  end
end
