#ifndef ARMSTRONG_NUMBERS_H
#define ARMSTRONG_NUMBERS_H

#include <stdbool.h>

unsigned power(unsigned x, unsigned exp) __attribute__ ((const));
bool is_armstrong_number(unsigned candidate) __attribute__ ((const));

#endif
