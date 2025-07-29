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
    case languages of
        [] -> 
            0
        _ :: xs  -> 
            1 + countLanguages xs


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
        x1 :: x2 :: [] ->
            x1 == "Elm" || x2 == "Elm"
        x1 :: x2 :: x3 :: [] ->
            x1 == "Elm" || x2 == "Elm"
        x :: xs ->
            x == "Elm"
