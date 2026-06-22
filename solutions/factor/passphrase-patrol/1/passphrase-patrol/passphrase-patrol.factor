USING: kernel regexp ;
IN: passphrase-patrol

CONSTANT: badge R/ [A-Z]{2}-\d{4}/

: valid-badge? ( badge -- ? )
    badge matches? ;

: badge-codes ( line -- codes )
    badge all-matching-subseqs ;

: digit-count ( string -- n )
    R/ \d/ count-matches ;

: redact ( line -- line' )
    R/ pass=\w*/ "pass=****" re-replace ;
