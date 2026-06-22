USING: kernel math ;
IN: difference-of-squares

: square-of-sum ( n -- m )
    [ 1 + ] keep * 2 / dup * ;

: sum-of-squares ( n -- m )
    [ 1 + ] keep [ 2 * 1 + ] keep * * 6 / ;

: difference-of-squares ( n -- m )
    [ square-of-sum ] keep sum-of-squares - ;
