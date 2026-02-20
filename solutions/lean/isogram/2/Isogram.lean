namespace Isogram

def isIsogram (phrase : String) : Bool := Id.run do
  let mut bmp := 0
  let mut pos := phrase.startValidPos
  while pos != phrase.endValidPos do
    let ch := pos.get!
    pos := pos.next!
    if ch.isAlpha then
      let bit := 1 <<< (ch.toLower.toNat - 'a'.toNat)
      if (bmp &&& bit) != 0 then 
        return false
      else
        bmp := bmp ||| bit
  return true

end Isogram
