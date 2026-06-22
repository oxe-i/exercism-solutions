USING: kernel math sequences sorting math.parser ;
IN: boutique-bookkeeping

: sort-by-price ( inventory -- sorted )
    [ second ] sort-by ;

: with-missing-price ( inventory -- filtered )
    [ second ] reject ;

: expensive-items ( inventory threshold -- count )
    swap [ second < ] with count ;

: cheapest-item ( inventory -- item )
    [ second ] minimum-by ;

: total-price ( inventory -- sum )
    [ second ] map-sum ;

: format-price-tag ( item -- str )
    [ first ] [ second number>string ] bi ": $" glue ;
