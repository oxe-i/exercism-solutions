namespace GameOfLife

def neighbours (matrix : Array (Array Bool)) (i j : Nat) : List Bool :=
  [ (i - 1, j - 1), (i - 1, j), (i - 1, j + 1),
    (i, j - 1), (i, j + 1),
    (i + 1, j - 1), (i + 1, j), (i + 1, j + 1) ]
    |>.filterMap fun
      | (0, _) => none
      | (_, 0) => none
      | (i, j) => matrix[i - 1]? >>= fun row => row[j - 1]?
      
def tick (matrix : Array (Array Bool)) : Array (Array Bool) :=
  matrix.mapIdx fun i row =>
    row.mapIdx fun j elem =>
      match neighbours matrix (i + 1) (j + 1) |>.count true with
      | 3 => true
      | 2 => elem
      | _ => false

end GameOfLife
