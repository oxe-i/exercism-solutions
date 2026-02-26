{
  encode: (plaintext) ->
    idx = 1
    acc = while idx <= #plaintext
      char = plaintext\sub idx, idx
      start = idx
      while idx <= #plaintext and char == plaintext\sub(idx, idx) do idx += 1
      count = idx - start
      "#{if count > 1 then count else ""}#{char}"
    table.concat acc 

  decode: (ciphertext) ->
    acc = for count, char in ciphertext\gmatch "(%d*)(.)"
      num = tonumber(count) or 1
      char\rep num      
    table.concat acc
}
