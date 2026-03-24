namespace Knapsack

structure Item where
  weight : Nat
  value : Int

def maximumValue (maximumWeight : Nat) (items : Array Item) : Int := Id.run do
  let upperBound := maximumWeight + 1
  let mut memo := Array.replicate upperBound (0 : Int)
  for ⟨iw, iv⟩ in items do
    for delta in [0:upperBound - iw] do
      let w := upperBound - delta - 1
      let candidate := iv + memo[w - iw]!
      memo := memo.set! w (max memo[w]! candidate)
  return memo[maximumWeight]!

end Knapsack
