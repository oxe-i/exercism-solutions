#include "difference_of_squares.h"

unsigned sum_of_squares(unsigned number) {
    unsigned result = 0;
    for (unsigned i = 1; i <= number; ++i) {
        result += i*i;
    }
    return result;
}

__attribute__ ((const))
unsigned square_of_sum(unsigned number) {
    const unsigned sum = (number * (number + 1)) >> 1;
    return sum * sum;
}

__attribute__ ((const))
unsigned difference_of_squares(unsigned number) {
    return square_of_sum(number) - sum_of_squares(number);
}

