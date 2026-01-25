namespace Pangram

def isPangram (sentence : String) : Bool :=
  let all := BitVec.fill 26 true
  all == sentence.foldl (fun seen ch =>
    let lower := ch.toLower
    if 'a' <= lower ∧ lower <= 'z'
    then
      let idx := lower.toNat - 'a'.toNat
      seen ||| BitVec.ofNat 26 (1 <<< idx)
    else seen
  ) (0 : BitVec 26)

end Pangram
