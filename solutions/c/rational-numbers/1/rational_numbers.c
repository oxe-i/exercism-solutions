#include "rational_numbers.h"

#include <math.h>

rational_t reduce(rational_t num) {
    if (!num.numerator || !num.denominator) 
        return (rational_t){ .numerator = 0, .denominator = 1 };

    const int sign = (num.numerator < 0 && num.denominator > 0) || (num.numerator > 0 && num.denominator < 0);
    
    num.numerator = num.numerator < 0? -num.numerator : num.numerator;
    num.denominator = num.denominator < 0? -num.denominator : num.denominator;

    for (int gcd = num.denominator; gcd > 1; --gcd) {
        if (!(num.numerator % gcd) && !(num.denominator % gcd)) {
            num.numerator /= gcd;
            num.denominator /= gcd;
            gcd = num.denominator;
        }
    }

    return (rational_t){ .numerator = sign? -num.numerator : num.numerator, .denominator = num.denominator }; 
}

rational_t absolute(rational_t num) {
    const rational_t reduced_num = reduce(num);
    return (rational_t){ .numerator = reduced_num.numerator < 0? -reduced_num.numerator : reduced_num.numerator, .denominator = reduced_num.denominator };
}

rational_t add(rational_t num1, rational_t num2) {
    const int common_multiple = num1.denominator * num2.denominator;
    num1.numerator *= num2.denominator;
    num2.numerator *= num1.denominator;
    return reduce((rational_t){ .numerator = num1.numerator + num2.numerator, .denominator = common_multiple });
}

rational_t subtract(rational_t num1, rational_t num2) {
    return add(num1, (rational_t){ .numerator = -num2.numerator, .denominator = num2.denominator });
}

rational_t multiply(rational_t num1, rational_t num2) {
    return reduce((rational_t){ .numerator = num1.numerator * num2.numerator, .denominator = num1.denominator * num2.denominator });
}

rational_t divide(rational_t num1, rational_t num2) {
    return multiply(num1, (rational_t){ .numerator = num2.denominator, .denominator = num2.numerator });
}

rational_t exp_rational(rational_t num, int exp) {
    if (exp < 0) {
        const int numerator = num.numerator;
        num.numerator = num.denominator;
        num.denominator = numerator;
        exp *= -1;
    }
    return reduce((rational_t){ .numerator = pow(num.numerator, exp), .denominator = pow(num.denominator, exp) });
}

float exp_real(int num, rational_t exp) {
    return pow(num, (float)exp.numerator / exp.denominator);
}