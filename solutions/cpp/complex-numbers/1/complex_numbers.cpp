#include "complex_numbers.h"

namespace complex_numbers {

    Complex::Complex() : m_real{}, m_imaginary{} {}
    Complex::Complex(double a) : m_real{a}, m_imaginary{} {}
    Complex::Complex(double a, double b) : m_real{a}, m_imaginary{b} {}
    Complex::Complex(std::pair<double, double> number) : m_real{std::move(number.first)}, m_imaginary{std::move(number.second)} {}

    auto Complex::real() const -> double {
        return m_real;
    }

    auto Complex::imag() const -> double {
        return m_imaginary;
    }

    auto Complex::operator+=(const Complex& n2) -> Complex& {
        m_real += n2.real();
        m_imaginary += n2.imag();
        
        return *this;
    }

    auto Complex::operator++() -> Complex& {
        m_real += 1;
        
        return *this;
    } 

    auto Complex::operator++(int) -> Complex {
        const auto value = *this;
        m_real += 1;
        
        return value;
    }

    auto Complex::operator-=(const Complex& n2) -> Complex& {
        m_real -= n2.real();
        m_imaginary -= n2.imag();
        
        return *this;
    }

    auto Complex::operator*=(const Complex& n2) -> Complex& {
        const auto second_real = n2.real();
        const auto second_imag = n2.imag();

        const auto new_real = (m_real * second_real) - (m_imaginary * second_imag);
        const auto new_imag = (m_imaginary * second_real) + (m_real * second_imag);

        m_real = new_real;
        m_imaginary = new_imag;

        return *this;
    }

    auto Complex::operator==(const Complex& n2) const -> bool {
        return m_real == n2.real() and m_imaginary == n2.imag();
    }

    auto Complex::operator/=(const Complex& n2) -> Complex& {
        if (n2 == Complex{0}) {
            throw std::domain_error("division by 0");
        }
        
        const auto second_real = n2.real();
        const auto second_imag = n2.imag();
        const auto square_of_absolute_value = (second_real * second_real) + (second_imag * second_imag);

        const auto new_real = ((m_real * second_real) + (m_imaginary * second_imag)) / square_of_absolute_value;
        const auto new_imag = ((m_imaginary * second_real) - (m_real * second_imag)) / square_of_absolute_value;

        m_real = new_real;
        m_imaginary = new_imag;

        return *this;        
    }

    Complex::operator double() const {
        return m_real;
    }

    auto Complex::abs() const -> Complex {
        const auto square_of_absolute_value = (m_real * m_real) + (m_imaginary * m_imaginary);
        const auto absolute_value = std::sqrt(square_of_absolute_value);
        
        return Complex{absolute_value};
    }

    auto Complex::exp() const -> Complex {
        const auto exp_of_real_part = std::exp(m_real);
        
        const auto real_of_result = exp_of_real_part * std::cos(m_imaginary);
        const auto imaginary_of_result = exp_of_real_part * std::sin(m_imaginary);

        return Complex{real_of_result, imaginary_of_result};
    }

    auto Complex::conj() const -> Complex {
        const auto conj_imag = -m_imaginary;
        
        return Complex{m_real, conj_imag};
    } 
}  // namespace complex_numbers
