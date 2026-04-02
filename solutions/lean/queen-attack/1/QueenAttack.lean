namespace QueenAttack

structure Queen where
  row : Int
  col : Int
  h : row ≥ 0 ∧ row < 8 ∧ col ≥ 0 ∧ col < 8
  deriving BEq, Repr
  
def create? (row col : Int) : Option Queen :=
  if h: row ≥ 0 ∧ row < 8 ∧ col ≥ 0 ∧ col < 8 then
    some { row, col, h }
  else none  
  
def canAttack (white black : Queen) : Bool :=
  let dRow := white.row - black.row
  let dCol := white.col - black.col
  dRow = 0 ∨ dCol = 0 ∨ dRow.natAbs = dCol.natAbs

end QueenAttack