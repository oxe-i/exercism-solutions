#if !defined(CLOCK_H)
#define CLOCK_H

#include <string>

namespace date_independent {
    namespace {
        constexpr int full_hour = 60;
        constexpr int full_day = 24;
    }

    namespace clock {
        struct time {
            int m_hour{};
            int m_minute{};

            auto plus(int minute) -> time&;
            explicit operator std::string() const;

            friend auto operator==(const time& fst, const time& sec) -> bool {
                return fst.m_hour == sec.m_hour and fst.m_minute == sec.m_minute;
            }

            friend auto operator!=(const time& fst, const time& sec) -> bool {
                return not (fst == sec);
            }
        };   
    
        auto at(int hour, int minute) -> time;
    };
}  // namespace date_independent

#endif // CLOCK_H