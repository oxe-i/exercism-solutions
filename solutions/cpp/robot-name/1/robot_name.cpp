#include "robot_name.h"

namespace robot_name {
    auto robot::generate_name() {
        auto rd = std::random_device{};
        auto mt = std::mt19937{rd()};

        auto dist_letters = std::uniform_int_distribution<char>('A', 'Z');
        auto dist_digits = std::uniform_int_distribution<uint8_t>(0, 9);

        m_name += std::string{dist_letters(mt)} + std::string{dist_letters(mt)};
        m_name += std::to_string(dist_digits(mt)) + std::to_string(dist_digits(mt)) + std::to_string(dist_digits(mt));

        while (used_names.check_name(m_name)) {
            robot::reset();
        }

        used_names.insert(m_name);
    }

    robot::robot() : m_name{} {
        robot::generate_name();
    }

    auto robot::name() const -> std::string {       
        return robot::m_name;  
    }

    auto robot::reset() -> void {
        const auto current_name = std::move(robot::m_name);        

        used_names.erase(robot::m_name);
        robot::m_name.clear();        
        generate_name();     
        
        while (std::equal(current_name.cbegin(), current_name.cend(), robot::m_name.cbegin())) {
            used_names.erase(robot::m_name);
            robot::m_name.clear();            
            generate_name();
        }
    }
}  // namespace robot_name
