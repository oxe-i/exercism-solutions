namespace Raindrops

def convert (number : Nat) : String :=
  let sounds := [(3, "Pling"), (5, "Plang"), (7, "Plong")].filterMap (fun (divisor, sound) => do
    guard (number % divisor == 0)
    pure sound
  )
  if sounds.isEmpty
  then s!"{number}"
  else String.join sounds

end Raindrops
