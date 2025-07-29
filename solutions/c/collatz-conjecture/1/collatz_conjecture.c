#include "collatz_conjecture.h"

int helper(int start, int count) {
    return start == 1? count :
           start &  1? helper(3 * start + 1, count + 1) :
           helper(start >> 1, count + 1);
}

int steps(int start) {
    return start <  1? ERROR_VALUE : helper(start, 0);
}