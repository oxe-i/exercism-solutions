{
  rebase: (argument) ->
    { :in_base, :out_base, :digits } = argument
    
    assert in_base >= 2, "input base must be >= 2"   
    assert out_base >= 2, "output base must be >= 2"  

    num = 0
    for digit in *digits
      assert 0 <= digit and digit < in_base, "all digits must satisfy 0 <= d < input base"
      num = num * in_base + digit

    return {0} if num == 0
    
    acc = {}
    while num > 0
      table.insert acc, 1, num % out_base
      num = math.floor(num / out_base)
    acc
}
