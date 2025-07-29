#include "square_root.h"

double square_root(unsigned x)
{
    double guess = x * 0.5;
    double precision = guess * guess - x;
    
    while (precision < -0.1 || precision > 0.1)
    {
        guess = 0.5 * (guess + x / guess);
        precision = guess * guess - x;
    }

    return guess;
}
