USING: kernel math.functions ;
IN: leap

: leap-year? ( year -- ? )
     [ 400 divisor? ]
     [ 100 divisor? not ] 
     [   4 divisor? ] tri and or ;
     
