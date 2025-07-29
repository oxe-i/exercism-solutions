#include "etl.h"

namespace etl {
    auto transform(const std::map<int, std::vector<char>>& old) -> std::map<char, int> {
        return std::accumulate(
                    old.begin(),
                    old.end(),
                    std::map<char, int>{},
                    [](auto&& acc, const auto& pair) {
                        int value = pair.first;

                        for (const auto& letter : pair.second) {
                            acc.try_emplace(std::tolower(letter), value);
                        }

                        return acc;
                    }
                );
    }
}  // namespace etl
