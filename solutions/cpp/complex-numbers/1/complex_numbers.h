#if !defined(COMPLEX_NUMBERS_H)
#define COMPLEX_NUMBERS_H

#include <utility>
#include <stdexcept>
#include <cmath>

namespace complex_numbers {

    class Complex {
    private:
        double m_real;
        double m_imaginary;
    public:
    //constructors
        Complex();
        Complex(double a);
        Complex(double a, double b);
        Complex(std::pair<double, double> number);

    //rule of five
        ~Complex() = default;
        Complex(const Complex& number) = default;
        Complex(Complex&& number) = default;
        Complex& operator=(const Complex& number) = default;
        Complex& operator=(Complex&& number) = default;

    //getters
        auto real() const -> double;
        auto imag() const -> double;

    //arithmetic operators
    //sum
        auto operator+=(const Complex& n2) -> Complex&;
        friend auto operator+(Complex n1, const Complex& n2) {
            return n1 += n2;
        }
    //increment
        auto operator++() -> Complex&;
        auto operator++(int) -> Complex;
    //subtraction
        auto operator-=(const Complex& n2) -> Complex&;
        friend auto operator-(Complex n1, const Complex& n2) {
            return n1 -= n2;
        }
    //decrement

    //multiplication
        auto operator*=(const Complex& n2) -> Complex&;       
        friend auto operator*(Complex n1, const Complex& n2) {
            return n1 *= n2;
        }
    //division
        auto operator/=(const Complex& n2) -> Complex&;
        friend auto operator/(Complex n1, const Complex& n2) {
            return n1 /= n2;
        }

    //conversion to double
        operator double() const;

    //equality
        auto operator==(const Complex& n2) const -> bool;

    //other functions
        auto abs() const -> Complex;
        auto exp() const -> Complex;
        auto conj() const -> Complex;
    };

}  // namespace complex_numbers

#endif  // COMPLEX_NUMBERS_H
