#if !defined(ROBOT_NAME_H)
#define ROBOT_NAME_H

#include <random>
#include <string>
#include <cstdint>
#include <unordered_set>

namespace robot_name {
    class robot {
    private:
        std::string m_name;    
        auto generate_name();
    public:
        robot();
        
        robot(const robot& other) = delete;
        auto operator=(const robot& other) = delete;
        robot(robot&& other) = delete;
        auto operator=(robot&& other) = delete;

        auto name() const -> std::string;
        auto reset() -> void;
        friend auto operator==(const robot& fst, const robot& sec) {
            return std::equal(fst.m_name.cbegin(), fst.m_name.cend(), sec.m_name.cbegin());
        }
    };

namespace {
    class {
    private:
        std::unordered_set<std::string> names {}; 
    public:
        auto check_name(const std::string& bot_name) -> bool {
            return names.count(bot_name);
        }
        auto insert(const std::string& bot_name) -> void {
            names.insert(bot_name);
        }
        auto erase(const std::string& bot_name) -> void {
            names.erase(bot_name);
        }
    } used_names;
}
}  // namespace robot_name

#endif // ROBOT_NAME_H