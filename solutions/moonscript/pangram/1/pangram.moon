is_pangram = (sentence) ->
  bmp = 0
  a = 'a'\byte!
  for ch in sentence\lower!\gmatch '%a'
    bmp |= (1 << (ch\byte! - a))
  bmp == (1 << 26) - 1
  
return is_pangram
