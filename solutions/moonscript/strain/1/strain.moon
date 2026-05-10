{
  keep: (xs, p) -> [ x for x in *xs when p x ] 
  discard: (xs, p) -> [ x for x in *xs when not p x ]
}
