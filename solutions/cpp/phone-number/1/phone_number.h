#if !defined(PHONE_NUMBER_H)
#define PHONE_NUMBER_H

#include <string>
#include <stdexcept>
#include <cctype>
#include <algorithm>

namespace phone_number {
    class phone_number {
    private:
        std::string m_number;
    public:
        phone_number(std::string unformatted_number);
        auto number() const -> std::string;
        auto area_code() const -> std::string;
        explicit operator std::string() const;
    };
}  // namespace phone_number

#endif // PHONE_NUMBER_H