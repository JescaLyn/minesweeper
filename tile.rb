class Tile
attr_accessor :mine, :revealed, :neighbor_bmbs

  def initialize
    @mine = false
    @revealed = false
    @neighbor_bmbs = 0
  end

  def display
    if @revealed == false
      "*"
    elsif @mine == true
      "M"
    else
      @neighbor_bmbs.to_s
    end
  end
end
