#include <cmath>

constexpr auto interest_rate(double balance) -> double
{
    if (balance < 0.0) return 3.213;
    if (balance < 1'000.0) return 0.5;
    if (balance < 5'000.0) return 1.621;    
    return 2.475;
}

constexpr auto yearly_interest(double balance) -> double
{
    return balance * (interest_rate(balance) / 100);
}

constexpr auto annual_balance_update(double balance) -> double
{
    return balance + yearly_interest(balance);
}

constexpr auto years_until_desired_balance(double balance, double target_balance) -> int
{
    auto num_of_years = 0;
    balance = std::abs(balance);
    target_balance = std::abs(target_balance);
    while (balance < target_balance)
    {
        balance = annual_balance_update(balance); 
        num_of_years++;
    }
    return num_of_years;
}