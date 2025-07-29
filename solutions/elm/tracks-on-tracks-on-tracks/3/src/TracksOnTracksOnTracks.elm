module TracksOnTracksOnTracks exposing (..)


newList : List String
newList =
    []


existingList : List String
existingList =
    [ "Elm", "Clojure", "Haskell" ]


addLanguage : String -> List String -> List String
addLanguage language languages =
    language :: languages


countLanguages : List String -> Int
countLanguages languages =
    List.length languages


reverseList : List String -> List String
reverseList languages =
    List.reverse languages


excitingList : List String -> Bool
excitingList languages =
   case languages of
       [] ->
           False
       x :: [] ->
           x == "Elm"
       x1 :: x2 :: _ ->
           x1 == "Elm" ||
           (countLanguages languages <= 3 &&
           x2 == "Elm")
