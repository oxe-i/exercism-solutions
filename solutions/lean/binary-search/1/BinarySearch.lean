namespace BinarySearch

def search (value : Int) (array : Array Int) (low : Fin array.size) (high : Fin array.size) : Option Nat :=
  let mid := (low.val + high.val) / 2
  match compare value array[mid] with
  | .eq => some mid
  | .gt =>
    -- mid < high.val -> mid + 1 <= high.val < array.size (by Fin property)
    if SuccMidFin : mid < high.val
    then search value array ⟨mid + 1, by grind⟩ high
    else none
  | .lt =>
    -- mid - 1 <= mid <= high < array.size (by Fin property)
    if PrevMidFin : mid > low.val
    then search value array low ⟨mid - 1, by grind⟩
    else none
  termination_by high.val - low.val
  -- on the first branch, grind can see that low.val <= mid -> low.val < mid + 1
  -- on the second branch, grind can see that mid > low.val -> mid > 0 -> mid - 1 < mid <= high -> mid - 1 < high
  -- so high.val - low.val always decreases, either by increase of low.val or by decrease of high.val

def find (value : Int) (array : Array Int) : Option Nat :=
  if arrayLen : 0 < array.size
  then search value array ⟨0, arrayLen⟩ ⟨array.size - 1, by grind⟩
  else none

end BinarySearch
