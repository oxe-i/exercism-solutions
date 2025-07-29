#if !defined(COMPLEX_NUMBERS_H)
#define COMPLEX_NUMBERS_H

#include <tuple>
#include <stdexcept>
#include <cstdint>

namespace math 
{
[[gnu::const]] constexpr auto are_double_equal(double n1, double n2)
{
    return (std::max(n1, n2) - std::min(n1, n2)) < 0.00001;
}

[[gnu::const]] constexpr auto root(double n)
{
    auto estimate = n / 1.25;
    auto next = 0.5 * (estimate + n / estimate);
    while (not are_double_equal(estimate, next))
    {
        estimate = next;
        next = 0.5 * (estimate + n / estimate);
    }
    return estimate;
}

[[gnu::const]] constexpr auto factorial(uint32_t n) -> uint64_t
{
    return n == 0 ? 1 : n * factorial(n - 1);
}

[[gnu::const]] constexpr auto power(double base, uint32_t exp) -> double
{
    constexpr auto square = [](double n) { return n * n; };
    return exp == 0 ? 1 :
            (exp & 1) == 1 ? base * square(power(base, exp >> 1)) :
            square(power(base, exp >> 1)); 
}

[[gnu::const]] constexpr auto exp(double n) -> double
{
    constexpr auto e = 2.7182818284;

    const auto floor = static_cast<uint64_t>(n);
    const auto remainder = n - floor;

    constexpr auto series = [](double n, unsigned long index, auto series) -> double
    {
        return index == 0 ? power(n, index) / factorial(index) : (power(n, index) / factorial(index)) + series(n, index - 1, series);
    };
    
    return series(remainder, 15, series) * power(e, floor); 
}

[[gnu::const]] constexpr auto cos(double n) -> double
{
    constexpr auto two_pi = 2 * 3.141592653;
    const auto first_quadrant_angle = n - (two_pi * static_cast<uint64_t>(n / two_pi));

    constexpr auto series = [](double n, uint64_t index, auto series) -> double
    {
        if (index == 0) return 1;
        return 
            (index % 4 == 2) ? 
            -(power(n, index) / (factorial(index))) + series(n, index - 2, series) :
            (power(n, index) / (factorial(index))) + series(n, index - 2, series);         
    };

    return series(first_quadrant_angle, 20, series);
}

[[gnu::const]] constexpr auto sin(double n) -> double
{
    constexpr auto two_pi = 2 * 3.141592653;
    const auto first_quadrant_angle = n - (two_pi * static_cast<uint64_t>(n / two_pi));

    constexpr auto series = [](double n, uint64_t index, auto series) -> double
    {
        if (index == 1) return n;
        return 
            (index - 1) % 4 == 2 ? 
            -(power(n, index) / (factorial(index))) + series(n, index - 2, series) :
            (power(n, index) / (factorial(index))) + series(n, index - 2, series);         
    };

    return series(first_quadrant_angle, 19, series);
}
}

namespace complex_numbers 
{

class Complex 
{
private:
    double m_real;
    double m_imag;
public:
//constructors
    constexpr Complex() : m_real{}, m_imag{} {}
    constexpr Complex(double a) : m_real{a}, m_imag{} {}
    constexpr Complex(double a, double b) : m_real{a}, m_imag{b} {}
    
//rule of five
    ~Complex() = default;
    constexpr Complex(const Complex& number) :
        m_real{number.m_real},
        m_imag{number.m_imag}
    {
    }
    constexpr Complex(Complex&& number) :
        m_real{std::move(number.m_real)},
        m_imag{std::move(number.m_imag)}
    {
    }
    constexpr Complex& operator=(const Complex& number)
    {
        m_real = number.m_real;
        m_imag = number.m_imag;
        return *this;
    }
    constexpr Complex& operator=(Complex&& number)
    {
        m_real = std::move(number.m_real);
        m_imag = std::move(number.m_imag);
        return *this;
    }

//getters
    constexpr auto real() const -> double { return m_real; }
    constexpr auto imag() const -> double { return m_imag; }

//arithmetic operators
//sum
    constexpr friend auto operator+(const Complex& n1, const Complex& n2) 
    { 
        const auto real = n1.real() + n2.real();
        const auto imag = n1.imag() + n2.imag();
        return Complex{ real, imag };
    }

    constexpr auto operator+=(const Complex& n2) -> Complex& 
    {
        *this = *this + n2;
        return *this;
    }
    
//subtraction
    constexpr friend auto operator-(const Complex& n1, const Complex& n2) 
    { 
        const auto real = n1.real() - n2.real(); 
        const auto imag = n1.imag() - n2.imag();
        return Complex{ real, imag };
    }

    constexpr auto operator-=(const Complex& n2) -> Complex& 
    {
        *this = *this - n2;
        return *this;
    }
    
//multiplication
    constexpr friend auto operator*(const Complex& n1, const Complex& n2) 
    { 
        const auto real = n1.real() * n2.real() - n1.imag() * n2.imag();
        const auto imag = n1.real() * n2.imag() + n1.imag() * n2.real();
        return Complex{ real, imag };
    }

    constexpr auto operator*=(const Complex& n2) -> Complex& 
    {
        *this = *this * n2;
        return *this;
    }      
    
//division
    constexpr friend auto operator/(const Complex& n1, const Complex& n2) 
    { 

        const auto real = (n1.real() * n2.real() + n1.imag() * n2.imag()) / 
                    (n2.real() * n2.real() + n2.imag() * n2.imag());
        const auto imag = (n1.imag() * n2.real() - n1.real() * n2.imag()) / 
                    (n2.real() * n2.real() + n2.imag() * n2.imag());
        return Complex{ real, imag };
    }

    constexpr auto operator/=(const Complex& n2) -> Complex&
    {
        *this = *this / n2;
        return *this;
    }
    
//equality
    constexpr auto operator==(const Complex& n2) const -> bool 
    {
        return math::are_double_equal(m_real, n2.real()) and 
            math::are_double_equal(m_imag, n2.imag());
    }

//other functions
    constexpr auto abs() const 
    { 
        return math::root(m_real * m_real + m_imag * m_imag); 
    }

    constexpr auto exp() const 
    { 
        return Complex
                {
                    math::exp(m_real) * math::cos(m_imag), 
                    math::exp(m_real) * math::sin(m_imag)
                }; 
    }

    constexpr auto conj() const 
    { 
        return Complex{ m_real, -m_imag }; 
    }
};

}  // namespace complex_numbers

#endif  // COMPLEX_NUMBERS_H
