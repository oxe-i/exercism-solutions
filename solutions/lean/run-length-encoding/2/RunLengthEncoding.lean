namespace RunLengthEncoding

def encode (string : String) : String := Id.run do
   let mut res := ""
   let mut count := 1
   let mut pos := string.startValidPos
   while pos != string.endValidPos do
     let ch := pos.get!
     pos := pos.next!
     while pos != string.endValidPos && pos.get! == ch do
       count := count + 1
       pos := pos.next!
     if count > 1 then
       res := res ++ s!"{count}"
       count := 1
     res := res.push ch
   return res
  
def decode (string : String) : String := Id.run do
  let mut res := ""
  let mut pos := string.startValidPos
  while pos != string.endValidPos do
    let mut num := ""
    while pos != string.endValidPos && pos.get!.isDigit do
      num := num.push pos.get!
      pos := pos.next!
    let count := match num.toNat? with
                 | none => 1
                 | some v => v
    let c := pos.get!
    res := res.pushn c count
    pos := pos.next!
  return res

end RunLengthEncoding
