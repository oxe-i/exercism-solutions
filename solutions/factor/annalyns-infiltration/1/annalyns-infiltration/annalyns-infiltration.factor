USING: kernel ;
IN: annalyns-infiltration

: can-do-fast-attack ( knight-awake -- ? )
    not ;

: can-spy ( knight-awake archer-awake prisoner-awake -- ? )
    or or ;

: andn ( x y -- ? )
    swap not and ;

: can-signal-prisoner ( archer-awake prisoner-awake -- ? )
    andn ;

: can-free-prisoner ( archer-awake dog-present prisoner-awake knight-awake -- ? )
    not and or andn ;
