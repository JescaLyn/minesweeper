class Tile
attr_accessor :mine, :revealed, :neighbors

  def initialize
    @mine = false
    @revealed = false
    @neighbors = 0
  end

  def display
    if @revealed == false
      "*"
    elsif @mine == true
      "M"
    else
      @neighbors.to_s
    end
  end
end
