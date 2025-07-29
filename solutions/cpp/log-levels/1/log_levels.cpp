#include <string>
#include <algorithm>
#include <cctype>

namespace log_line {
    auto message(const std::string& log) -> std::string {
        const auto start_msg = log.find(":") + 2;
        return log.substr(start_msg);
    }

    auto log_level(const std::string& log) -> std::string {
        const auto start_level = log.find("[") + 1;
        const auto end_level = log.find("]") - 1;
        const auto size_of_level = end_level - start_level + 1;

        auto level = log.substr(start_level, size_of_level);

        std::transform(level.cbegin(), level.cend(), level.begin(),
            [](const auto& ch) {
                return std::toupper(ch);
            });

        return level;
    }

    auto reformat(const std::string& log) -> std::string {
        const auto msg = message(log);
        const auto lvl = log_level(log);

        return msg + " (" + lvl + ")";
    }
} // namespace log_line
