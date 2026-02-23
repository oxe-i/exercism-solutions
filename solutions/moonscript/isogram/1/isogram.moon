{
  is_isogram: (phrase) ->
    bmp = 0
    a = "a"\byte!
    for c in phrase\lower!\gmatch '%a'
      bit = 1 << (c\byte! - a)
      return false if (bmp & bit) != 0
      bmp |= bit
    true
}
