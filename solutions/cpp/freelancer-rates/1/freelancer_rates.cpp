// INFO: Headers from the standard library should be inserted at the top via
#include <cmath>

// daily_rate calculates the daily rate given an hourly rate
double daily_rate(double hourly_rate) {
    // TODO: Implement a function to calculate the daily rate given an hourly
    // rate
    return hourly_rate * 8;
}

// apply_discount calculates the price after a discount
double apply_discount(double before_discount, double discount) {
    // TODO: Implement a function to calculate the price after a discount.
    const auto percentage = discount / 100;
    return before_discount - 
        (before_discount * percentage);
}

// monthly_rate calculates the monthly rate, given an hourly rate and a discount
// The returned monthly rate is rounded up to the nearest integer.
int monthly_rate(double hourly_rate, double discount) {
    // TODO: Implement a function to calculate the monthly rate, and apply a
    // discount.
    const auto hourly_with_discount = apply_discount(hourly_rate, discount);
    const auto daily_with_discount = daily_rate(hourly_with_discount);
    return std::ceil(22 * daily_with_discount);
}

// days_in_budget calculates the number of workdays given a budget, hourly rate,
// and discount The returned number of days is rounded down (take the floor) to
// the next integer.
int days_in_budget(int budget, double hourly_rate, double discount) {
    // TODO: Implement a function that takes a budget, an hourly rate, and a
    // discount, and calculates how many complete days of work that covers.
    const auto hourly_with_discount = apply_discount(hourly_rate, discount);
    const auto daily_with_discount = daily_rate(hourly_with_discount);
    return std::floor(budget / daily_with_discount);
}