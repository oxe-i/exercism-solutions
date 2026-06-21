USING: kernel math math.functions math.order ;
IN: currency-conversion

: exchange-money ( budget exchange-rate -- exchanged )
    / ;

: get-change ( budget exchanging-value -- change )
    - ;

: value-of-bills ( denomination number-of-bills -- value )
    * ;

: number-of-bills ( amount denomination -- bills )
    / floor >integer ;

: leftover-of-bills ( amount denomination -- leftover )
    mod ;

: exchangeable-value ( denomination budget spread exchange-rate -- value )
    dup rot 100.0 / * + / over number-of-bills * ;

: safe-change ( budget exchanging-value -- change )
    get-change 0 max ;

: cap-spend ( budget price -- spend )
    min ;
