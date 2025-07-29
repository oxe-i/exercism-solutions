#include "allergies.h"

namespace allergies {
    allergy_test::allergy_test(uint64_t score) : allergies{}
    {
        const auto allergens = std::array<std::string, 8> {
            "eggs",
            "peanuts",
            "shellfish",
            "strawberries",
            "tomatoes",
            "chocolate",
            "pollen",
            "cats"
        };

        for (uint8_t shift{}; shift < 8; ++shift) {
            if (score bitand (1 << shift)) {
                allergies.emplace(allergens.at(shift));
            }
        }
    }

    auto allergy_test::is_allergic_to(std::string allergen) -> bool {
        return allergies.count(allergen);
    }

    auto allergy_test::get_allergies() const -> std::unordered_set<std::string> {
        return allergies;
    }
    
}  // namespace allergies
