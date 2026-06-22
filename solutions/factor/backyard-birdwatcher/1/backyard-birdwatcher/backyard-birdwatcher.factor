USING: kernel sequences math ;
IN: backyard-birdwatcher

: today ( days -- count )
    last ;
    
: increment-todays-count ( days -- new-days )
    unclip-last 1 + suffix ;

: has-day-without-birds? ( days -- ? )
    [ 0 = ] any? ;

: count-for-first-days ( days n -- count )
    head sum ;

: busy-days ( days -- count )
    [ 5 >= ] count ;

: pad-missing-days ( days n -- new-days )
    0 pad-tail ;
