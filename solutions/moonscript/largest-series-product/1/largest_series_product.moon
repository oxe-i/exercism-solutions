{
  largest_product: (digits, span) ->
    assert span >= 0, "span must not be negative"
    assert span <= #digits, "span must not exceed string length"
    assert not digits\match("%D"), "digits input must only contain digits"

    return 1 if span == 0
    
    max_product = 0    
    for i = 1, #digits - span + 1 
      product = 1
      for digit in digits\sub(i, i + span - 1)\gmatch "." 
        product *= tonumber digit        
      max_product = math.max max_product, product      
    max_product      
}
