USING: kernel math.vectors arrays sequences ;
IN: coordinate-choreography

: translate-2d ( dx dy -- quot )
    '[ { _ _ } v+ ] ;

: scale-2d ( sx sy -- quot )
    '[ { _ _ } v* ] ;

: compose-transformations ( f g -- h )
    compose ;

: apply-transformation ( point f -- point' )
    call ; inline
    
: transform-points ( points f -- points' )
    map ; inline
