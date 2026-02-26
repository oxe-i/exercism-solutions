{
  row: (str, idx) ->
    rows = [ r for r in str\gmatch "[^\n]+" ]
    [ tonumber n for n in rows[idx]\gmatch "%S+" ]

  column: (str, idx) ->
    col = {}
    for row in str\gmatch "[^\n]+"
      count = idx
      for elem in row\gmatch "%S+"
         count -= 1
         if count == 0
           table.insert col, tonumber elem
           break
    col
}
