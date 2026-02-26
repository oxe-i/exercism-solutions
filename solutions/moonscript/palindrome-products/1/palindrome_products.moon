is_palindrome = (n) ->
  stringified = tostring n
  stringified == stringified\reverse!

{
  smallest: (min, max) ->
    assert min <= max, "min must be <= max"
    
    local palindrome
    factors = {}
      
    for f1 = min, max
      break if palindrome and f1 * f1 > palindrome        
      for f2 = f1, max
        product = f1 * f2          
        if palindrome
          if product == palindrome
            table.insert factors, {f1, f2}            
          break if product >= palindrome               
          if is_palindrome product
            palindrome, factors = product, { {f1, f2} }                 
        else if is_palindrome product
          palindrome, factors = product, { {f1, f2} }
          
    palindrome, factors
      
  largest: (min, max) ->
    assert min <= max, "min must be <= max"

    local palindrome
    factors = {}
    
    for f2 = max, min, -1
      break if palindrome and f2 * f2 < palindrome      
      for f1 = f2, min, -1
        product = f1 * f2        
        if palindrome
          if product == palindrome
            table.insert factors, {f1, f2}            
          break if product <= palindrome              
          if is_palindrome product
            palindrome, factors = product, { {f1, f2} }            
        else if is_palindrome product
          palindrome, factors = product, { {f1, f2} }
          
    palindrome, factors
}
