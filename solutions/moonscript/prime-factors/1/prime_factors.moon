{
  factors: (number) ->
    with acc = {}
      while number > 1
        found = false
        
        for i = 2, math.sqrt number
          if number % i == 0
            table.insert acc, i
            number /= i
            found = true
            break

        unless found
          table.insert acc, number
          break 
}
