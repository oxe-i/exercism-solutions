{
  abbreviate: (phrase) ->
    words = [ w\sub(1, 1)\upper! for w in phrase\gmatch "%a+'?%a*%f[^%a]" ]
    table.concat words
}
