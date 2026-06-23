USING: kernel math.functions math.parser sequences formatting ;
IN: raindrops

:: (drops) ( n d c -- str )
   n d divisor? [ c "Pl%cng" sprintf ] [ "" ] if ;

: convert ( n -- str )
   dup
   [ 3 CHAR: i (drops) ]
   [ 5 CHAR: a (drops) ]
   [ 7 CHAR: o (drops) ] tri 3append
   [ number>string ] [ nip ] if-empty ;
