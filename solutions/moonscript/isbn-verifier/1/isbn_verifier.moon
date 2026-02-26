{
  is_valid: (input) ->
    mult = 10
    acc = 0
    for char in input\gmatch "."
      continue if char == "-"
      value = if char == "X"
        return false if mult != 1
        10
      else
        return false unless mult > 0 and char\match "%d"
        tonumber char
      acc += mult * value
      mult -= 1
    mult == 0 and acc % 11 == 0
}
