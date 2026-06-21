USING: kernel ranges math sequences strings math.functions ;
IN: bunting-bonanza

:: >map-string ( g q -- str )
    g [ q call( x -- y ) ] map >string ;

:: >iota-map-string ( n q -- str )
    n <iota> q >map-string ;

: alphabet-bunting ( n -- str )
    [ CHAR: a + ] >iota-map-string ;
   
: counting-bunting ( n -- str )
    [ 10 mod CHAR: 0 + ] >iota-map-string ;

:: >pred-string ( n p a b -- str )
    n [ p call( x -- ? ) [ a ] [ b ] if ] >iota-map-string ;

: stripe-bunting ( n -- str )
    [ even? ] CHAR: * CHAR: - >pred-string ;

: marker-bunting ( n -- str )
    [ 5 divisor? ] CHAR: | CHAR: . >pred-string ;

: valley-bunting ( -- str )
    -5 5 [a..b) [ abs CHAR: 0 + ] >map-string ;
