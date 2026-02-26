class Queen
  new: (@row, @col) =>
    assert 0 <= @row and @row <= 7, "invalid position"
    assert 0 <= @col and @col <= 7, "invalid position"

  can_attack: (other) =>
    delta_r = math.abs(other.row - @row)
    delta_c = math.abs(other.col - @col)
    other.row == @row or other.col == @col or delta_r == delta_c 
