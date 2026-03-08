namespace Hamming

/--
  Since a `String` is implemented on top of a `ByteArray`, i.e., a dynamic array of bytes, it suffers from the same issues as `Array`.
  In particular, if the reference to the string is not unique, updating it may require allocating a new array.

  It is possible to convert strings to `List Char`.
  This has several benefits for proofs and inductive reasoning.
  It also gives access to pattern matching and a more functional-friendly API.
  However, such a conversion is itself an `O(n)` operation.
-/
def listDistance (strand1 strand2 : String) : Option Nat :=
  let rec go (acc : Nat) : List Char → List Char → Option Nat
    | [], [] => some acc
    | _, []  => none
    | [], _  => none
    | a :: as, b :: bs =>
      if a ≠ b
      then go (acc + 1) as bs
      else go acc as bs
  go 0 strand1.toList strand2.toList

/-
  Another option is to use a `String.Slice`, which is just a view over a `String`.
  It can be thought of as a tuple containing the underlying string, a start position, and an end position.
  This means that simple position updates involving slices, such as `drop` or `take`, are `O(1)`.
-/
def sliceDistance (strand1 strand2 : String) : Option Nat := do
  guard (strand1.length = strand2.length)
  return strand1.toSlice.foldl
    (fun (count, slice) c1 =>
      let c2 := slice.front
      let s2 := slice.drop 1
      if c1 ≠ c2
      then (count + 1, s2)
      else (count, s2))
    (init := (0, strand2.toSlice))
    |>.fst

/--
  Often, an imperative approach is the most efficient choice in performance-sensitive code.
  It is possible to iterate over the characters of a `String` using `String.Pos` without any allocation.

  In the Lean version used by the track (4.25.2), the string API still relies on `String.ValidPos`, which has since been deprecated.
  Note that this version is about three months old at the time of writing: Lean releases new versions roughly every month.

  For this reason, we use `String.Slice.Pos` in order to keep the code forward-compatible.
-/

def imperativeDistance (strand1 strand2 : String) : Option Nat := do
  let s1 := strand1.toSlice
  let s2 := strand2.toSlice
  let mut p1 := s1.startPos
  let mut p2 := s2.startPos
  let mut diff := 0
  while h: p1 ≠ s1.endPos ∧ p2 ≠ s2.endPos do
    let c1 := p1.get h.left  -- accesses the left side of h, i.e., p1 ≠ s1.endPos
    let c2 := p2.get h.right -- accesses the right side of h, i.e., p2 ≠ s2.endPos
    p1 := p1.next h.left
    p2 := p2.next h.right
    if c1 ≠ c2 then diff := diff + 1
  guard (p1 = s1.endPos ∧ p2 = s2.endPos)
  return diff

def distance := listDistance

end Hamming
