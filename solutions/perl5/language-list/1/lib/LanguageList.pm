package LanguageList;

use v5.38;

our @Languages;

sub add_language ($language) {
  push(@Languages, $language);
}

sub remove_language () {
  pop(@Languages);
}

sub first_language () {
  $LanguageList::Languages[0];
}

sub last_language () {
  $LanguageList::Languages[-1];
}

sub get_languages (@elements) {
    my @slice;
    for my $element (@elements) {        
        push(@slice, $LanguageList::Languages[$element - 1]);
    }
    @slice;
}

sub has_language ($language) {
    scalar grep {$_ eq $language} @Languages;
}
