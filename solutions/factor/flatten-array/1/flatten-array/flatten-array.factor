USING: kernel sequences arrays vectors ;
IN: flatten-array

: flatten ( array -- flat )
     V{ } clone 
     [ dup array? 
       [ flatten over push-all ] 
       [ [ over push ] when* ] if ]
     reduce >array ;
