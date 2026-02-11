namespace GameOfLife

def neighbours (matrix : Array (Array Bool)) (i j : Int) : List Bool :=
  [i - 1, i, i + 1].flatMap (fun r => [(r, j - 1), (r, j), (r, j + 1)])
      |>.filterMap (fun (r, c) =>
        if r < 0 || c < 0 || (r == i && j == c) 
        then none
        else matrix[r.toNat]? >>= (.[c.toNat]?)
      )
      
def tick (matrix : Array (Array Bool)) : Array (Array Bool) :=
  matrix.mapIdx (fun i row =>
    let ii := Int.ofNat i
    row.mapIdx (fun j e =>
      let ij := Int.ofNat j
      match neighbours matrix ii ij |>.count true with
        | 3 => true
        | 2 => e
        | _ => false
    ) 
  )

end GameOfLife
