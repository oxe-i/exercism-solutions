#include "grade_school.h"

namespace grade_school {
    auto school::roster() const -> std::map<int, std::vector<std::string>> {
        return m_roster;
    }

    auto school::add(std::string name, int grade) -> void {
        if (const auto first_insert = m_roster.insert({grade, std::vector<std::string>{name}}); 
            not first_insert.second) {            
            m_roster[grade].emplace_back(name); 
            std::sort(m_roster[grade].begin(), m_roster[grade].end());
        }       
    }

    auto school::grade(int value) const -> std::vector<std::string> {
        if (m_roster.count(value)) {
            return m_roster.at(value);
        }
        
        return std::vector<std::string>{};
    }
}  // namespace grade_school
