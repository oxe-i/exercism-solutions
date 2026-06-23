USING: kernel math ;
IN: eliuds-eggs

: (egg-count) ( acc n -- count )
    [ ] [ [ 1 + ] dip dup 1 - bitand (egg-count) ] if-zero ;

: egg-count ( n -- count )
    0 swap (egg-count)  ;
