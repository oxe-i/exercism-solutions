complement = { G: "C", C: "G", T: "A", A: "U" }

to_rna = (dna) ->
  dna\gsub("[ACGT]", complement)

return to_rna
