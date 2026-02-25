drops = { {3, "i"}, {5, "a"}, {7, "o"} }

raindrops = (num) ->
  sounds = table.concat [ "Pl#{v}ng" for {n, v} in *drops when num % n == 0 ]
  if #sounds > 0 then sounds else "#{num}" 
  
raindrops
