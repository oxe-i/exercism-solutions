USING: kernel math combinators ;
IN: joiners-journey

: kerf ( length -- kerf )
    100 / 2 * ;
    
: with-kerf ( length -- length+kerf )
    [ kerf ] keep + ;

: finish ( length -- finish )
    100 / 5 * ;

: kerf-and-finish ( length -- kerf finish )
    [ kerf ] [ finish ] bi ;

: cut-card ( length -- length kerf finish )
    [ ] [ kerf ] [ finish ] tri ;

: per-piece ( bolt-length pieces -- per-piece )
    [ with-kerf ] dip / ;

: compare-bolts ( length-a length-b -- kerf-a kerf-b )
    [ kerf ] bi@ ;
