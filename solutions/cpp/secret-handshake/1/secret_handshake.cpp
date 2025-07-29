#include "secret_handshake.h"

namespace secret_handshake {
    auto commands(uint8_t number) -> std::vector<std::string> {
        const auto actions = std::array<std::string, 4> {
            "wink",
            "double blink",
            "close your eyes",
            "jump"
        };

        auto sequence = std::vector<std::string>{};

        for (uint8_t shift{}; shift < 4; shift++) {
            if (number bitand (1 << shift)) {
                sequence.emplace_back(actions.at(shift));
            }
        }

        if (number bitand 16) {
            std::reverse(sequence.begin(), sequence.end());
        }

        return sequence;
    }
}  // namespace secret_handshake
