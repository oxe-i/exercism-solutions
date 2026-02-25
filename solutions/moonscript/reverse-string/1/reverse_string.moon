reverse = (str) ->
  chars = [ utf8.char c for _, c in utf8.codes str ]
  table.concat [ chars[i] for i = #chars, 1, -1 ]

return reverse
