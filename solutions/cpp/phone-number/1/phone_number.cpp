#include "phone_number.h"

namespace phone_number {
    phone_number::phone_number(std::string unformatted_number) {
        unformatted_number.erase(
            std::remove_if(unformatted_number.begin(), unformatted_number.end(),
            [](unsigned char ch) {
                return not std::isdigit(ch);
            }),
            unformatted_number.end()
        );

        if (const auto size = unformatted_number.size(); size < 10 or size > 11) {
            throw std::domain_error("number of invalid size.");
        } else if (size == 11 and unformatted_number.front() != '1') {
            throw std::domain_error("invalid country code.");
        } else if (size == 11) {
            unformatted_number.erase(
                unformatted_number.begin(), unformatted_number.begin() + 1);
        }

        if (unformatted_number.at(0) < '2') {
            throw std::domain_error("invalid area code.");
        } else if (unformatted_number.at(3) < '2') {
            throw std::domain_error("invalid exchange code.");
        }

        m_number = std::move(unformatted_number);
    }

    auto phone_number::number() const -> std::string {
        return m_number;
    }

    auto phone_number::area_code() const -> std::string {
        return {m_number.begin(), m_number.begin() + 3};
    }

    phone_number::operator std::string() const {
        return "(" + area_code() + ") " + 
            std::string{m_number.begin() + 3, m_number.begin() + 6} + "-" +
            std::string{m_number.begin() + 6, m_number.end()};
    }
    
}  // namespace phone_number
