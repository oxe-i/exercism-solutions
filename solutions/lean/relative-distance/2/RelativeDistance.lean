import Std.Data.HashSet
import Std.Data.HashMap

namespace RelativeDistance

abbrev Name := String
abbrev Relatives := Std.HashSet String
abbrev Parent := String
abbrev Children := List String
abbrev FamilyMap := Std.HashMap Name Relatives

partial def traverse 
  (target : Name) 
  (firstDegree : Std.HashMap Name Relatives) 
  (degree : Nat) 
  (seen : Relatives) 
  (layer : Relatives) 
  : Option Nat :=
  if target ∈ layer
  then some degree
  else do
    let nextSeen := seen.insertMany layer
    let nextLayer ← layer.foldM (init := {}) fun m c => do 
      m.insertMany (← (·.filter (· ∉ nextSeen)) <$> firstDegree[c]?)
    guard !nextLayer.isEmpty
    traverse target firstDegree (degree + 1) nextSeen nextLayer

def insertChildren (parent : Parent) (children : Children) (map : FamilyMap) : FamilyMap :=
  map.alter parent (fun
    | none           => Std.HashSet.ofList children
    | some relatives => relatives.insertMany children
  )

def insertParents (child : Name) (parent : Parent) (children : Children) (map : FamilyMap) : FamilyMap :=
  let siblings := children.filter (· ≠ child)
  map.alter child (fun
    | none           => Std.HashSet.ofList (parent :: siblings)
    | some relatives => relatives.insertMany (parent :: siblings)
  )

def degreeOfSeparation (familyTree : List (Parent × Children)) (personA personB : String) : Option Nat := do
  let firstDegree := familyTree.foldr (init := {}) fun (p, cs) map => 
    cs.foldr (fun c => insertChildren p cs ∘ insertParents c p cs) map
  let layer ← firstDegree[personA]?
  traverse personB firstDegree 1 {} layer

end RelativeDistance
