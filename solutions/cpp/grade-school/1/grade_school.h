#if !defined(GRADE_SCHOOL_H)
#define GRADE_SCHOOL_H

#include <vector>
#include <string>
#include <map>
#include <cstdint>
#include <utility>
#include <algorithm>

namespace grade_school {
    class school {
    public:
        school() = default;
        auto roster() const -> std::map<int, std::vector<std::string>>;
        auto add(std::string name, int grade) -> void;
        auto grade(int value) const -> std::vector<std::string>;
    private:
        std::map<int, std::vector<std::string>> m_roster;
    };

}  // namespace grade_school

#endif // GRADE_SCHOOL_H