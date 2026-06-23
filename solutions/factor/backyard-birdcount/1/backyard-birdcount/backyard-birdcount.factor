USING: kernel sequences math ;
IN: backyard-birdcount

: today ( days -- count/f )
    [ f ] [ first ] if-empty ;

: increment-day-count ( days -- new-days )
    [ { 1 } ] [ unclip 1 + prefix ] if-empty ;

! PRIVATE hides the function from external callers
! inline to call op
! :: allows the function to refer values by name
! :> binds the stack to named values

<PRIVATE
:: (tail-helper) ( op: ( a b -- c ) acc seq -- res )
    seq
    [ acc ]
    [ unclip-slice :> ( rest first ) 
      op acc first op call rest (tail-helper) ]
    if-empty ; inline recursive
PRIVATE>

:: has-day-without-birds? ( days -- ? )
    [ zero? or ] f days (tail-helper) ;

:: total ( days -- sum )
    [ + ] 0 days (tail-helper) ;

:: busy-days ( days -- count )
    [ 5 >= [ 1 + ] when ] 0 days (tail-helper) ;
