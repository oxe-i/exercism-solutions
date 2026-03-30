namespace TwelveDays

abbrev VerseIndex := { x : Nat // 1 ≤ x ∧ x ≤ 12 }

def gifts : Vector String 12 := ⟨#[
  "a Partridge in a Pear Tree",
  "two Turtle Doves",
  "three French Hens",
  "four Calling Birds",
  "five Gold Rings",
  "six Geese-a-Laying",
  "seven Swans-a-Swimming",
  "eight Maids-a-Milking",
  "nine Ladies Dancing",
  "ten Lords-a-Leaping",
  "eleven Pipers Piping",
  "twelve Drummers Drumming"
], by decide⟩

def ordinals : Vector String 12 := ⟨#[
  "first", "second", "third", "fourth",
  "fifth", "sixth", "seventh", "eighth",
  "ninth", "tenth", "eleventh", "twelfth"
], by decide⟩

def intro (i : Fin 12) : String :=
  s!"On the {ordinals.get i} day of Christmas my true love gave to me: "

def verseGifts (i : { x : Fin 12 // 0 < x }) : String :=
  gifts.extract 1 (i + 1) 
  |>.reverse 
  |>.toList 
  |> String.intercalate ", "
  |>.append s!", and {gifts.get 0}"

def verse (i : Fin 12) : String :=
  let giftsVerses := if h: i = 0 then gifts.get i ++ "." 
                     else verseGifts ⟨i, by omega⟩ ++ "."
  intro i ++ giftsVerses

def allVerses : List String :=
  (List.finRange 12).map verse

def recite (startVerse endVerse : VerseIndex) : List String :=
  allVerses
  |>.drop (startVerse - 1)
  |>.take (endVerse - startVerse + 1)

end TwelveDays
