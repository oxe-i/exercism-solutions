namespace Bob

inductive ConversationType where
  | question       : ConversationType
  | yell           : ConversationType
  | yelledQuestion : ConversationType
  | silence        : ConversationType
  | other        : ConversationType
  deriving BEq

def ConversationType.reply : ConversationType -> String
  | .question       => "Sure."
  | .yell           => "Whoa, chill out!"
  | .yelledQuestion => "Calm down, I know what I'm doing!"
  | .silence        => "Fine. Be that way!"
  | .other          => "Whatever."

def isQuestion (text : String) : Bool :=
  match text.toSlice.revFind? (·=='?') with
  | none => false
  | some questionPos =>
    match text.toSlice.revFind? Char.isAlpha with
    | none => true
    | some letterPos => questionPos > letterPos

def isSilence (text : String) : Bool :=
  text.all Char.isWhitespace

def isYell (text : String) : Bool :=
  let hasLetter := text.any Char.isAlpha
  let allUpper := text.foldl (λ acc letter => if letter.isAlpha then acc && letter.isUpper else acc) true
  hasLetter && allUpper

def classifyText (text : String) : ConversationType :=
  let question := isQuestion text
  let yell := isYell text
  if question && yell then .yelledQuestion
  else if question then .question
  else if yell then .yell
  else if isSilence text then .silence
  else .other

def response (heyBob : String) : String :=
  (classifyText heyBob).reply

end Bob
