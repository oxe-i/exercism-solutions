count_eggs = (num) ->
  bits = 0
  while num > 0
    bits += 1
    num &= num - 1
  bits
  
count_eggs
