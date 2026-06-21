USING: kernel math combinators ;
IN: darts

: score ( x y -- n )
    dup * swap dup * + 
    {
      { [ dup 100.0 > ] [ drop 0 ] }
      { [ dup  25.0 > ] [ drop 1 ] }
      { [ dup   1.0 > ] [ drop 5 ] }
      [ drop 10 ]
    } cond ;
