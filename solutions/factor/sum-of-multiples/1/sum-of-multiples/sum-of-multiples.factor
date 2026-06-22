USING: kernel sequences sets ranges math ;
IN: sum-of-multiples

:: multiples ( limit factor -- seq )
    factor [ limit 1 - ] call factor <range> ;

: sum-of-multiples ( factors limit -- sum )
    swap [ 0 <= ] reject [ multiples ] with map concat members sum ;
