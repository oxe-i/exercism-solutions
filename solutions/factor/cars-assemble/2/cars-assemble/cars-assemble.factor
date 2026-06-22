USING: kernel math math.order math.functions combinators ;
IN: cars-assemble

! Define base-speed.
CONSTANT: base-speed 221

: production-status ( speed -- status )
    zero? [ "stopped" ] [ "running" ] if ;

: success-rate ( speed -- rate )
    {
       { [ dup 0 = ] [ drop 0.0 ] }
       { [ dup 1 4 between? ] [ drop 1.0 ] }
       { [ dup 5 8 between? ] [ drop 0.9 ] }
       { [ dup 9 = ] [ drop 0.8 ] }
       [ drop 0.77 ]
    } cond ;

: production-rate-per-hour ( speed -- rate )
    dup base-speed * swap success-rate * ;

: working-items-per-minute ( speed -- count )
    production-rate-per-hour 60 / floor >integer ;
