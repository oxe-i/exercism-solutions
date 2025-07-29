#if !defined(ALLERGIES_H)
#define ALLERGIES_H

#include <unordered_set>
#include <string>
#include <cstdint>
#include <array>

namespace allergies {
    class allergy_test {
    private:
        std::unordered_set<std::string> allergies;
    public:
        allergy_test(uint64_t score);
        auto is_allergic_to(std::string allergen) -> bool;
        auto get_allergies() const -> std::unordered_set<std::string>;
    };
}  // namespace allergies

#endif // ALLERGIES_H