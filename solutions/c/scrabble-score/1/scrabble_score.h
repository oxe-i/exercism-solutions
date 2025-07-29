#ifndef SCRABBLE_SCORE_H
#define SCRABBLE_SCORE_H

unsigned values_index(char letter) __attribute__ ((const));
unsigned score(const char *word) __attribute__ ((const));

#endif
