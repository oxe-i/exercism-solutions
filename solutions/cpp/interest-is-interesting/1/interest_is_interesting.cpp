namespace {
constexpr auto negative = 3.213;
constexpr auto less_than_1000 = 0.5;
constexpr auto from_1000_to_less_than_5000 = 1.621;
constexpr auto from_5000 = 2.475;
}

// interest_rate returns the interest rate for the provided balance.
double interest_rate(double balance) {
    if (balance < 0.0) {
        return negative;
    }
    else if (balance < 1'000.0) {
        return less_than_1000;
    }
    else if (balance < 5'000.0) {
        return from_1000_to_less_than_5000;
    }
    
    return from_5000;
}

// yearly_interest calculates the yearly interest for the provided balance.
double yearly_interest(double balance) {
    return balance * (interest_rate(balance) / 100);
}

// annual_balance_update calculates the annual balance update, taking into
// account the interest rate.
double annual_balance_update(double balance) {
    return balance + yearly_interest(balance);
}

// years_until_desired_balance calculates the minimum number of years required
// to reach the desired balance.
int years_until_desired_balance(double balance, double target_balance) {
    if ((balance > 0 and balance >= target_balance) or (balance < 0 and balance <= target_balance)) {
        return 0;
    }

    const auto updated_balance = annual_balance_update(balance);
    
    return 1 + years_until_desired_balance(updated_balance, target_balance);
}